import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/notifications/app_toast.dart';
import '../../../../core/presentation/views/error_screen.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../cards/presentation/views/cards_page.dart';
import '../../../initial_setup/initial_setup_providers.dart';
import '../../../receipt_scan/data/receipt_scan_remote_data_source.dart';
import '../../../receipt_scan/receipt_scan_providers.dart';
import '../../../transactions/presentation/views/transaction_editor_screen.dart';
import '../../../transactions/presentation/views/transactions_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static const _navigationItems = [
    ui.AppNavigationItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      label: 'Home',
    ),
    ui.AppNavigationItem(
      icon: Icons.credit_card_outlined,
      selectedIcon: Icons.credit_card_rounded,
      label: 'Cards',
    ),
    ui.AppNavigationItem(
      icon: Icons.add_rounded,
      label: 'Add',
      isPrimaryAction: true,
    ),
    ui.AppNavigationItem(
      icon: Icons.receipt_long_outlined,
      selectedIcon: Icons.receipt_long_rounded,
      label: 'Transactions',
    ),
    ui.AppNavigationItem(
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
      label: 'Profile',
    ),
  ];

  int _selectedIndex = 0;
  bool _isNavigatingToError = false;

  void _selectDestination(int index) {
    if (index == 2) {
      _showQuickAdd();
      return;
    }

    setState(() => _selectedIndex = index);
  }

  void _showQuickAdd() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: ui.AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add a transaction',
                  style: Theme.of(sheetContext).textTheme.titleLarge,
                ),
                const SizedBox(height: ui.AppSpacing.sm),
                ListTile(
                  key: const Key('scan-receipt-action'),
                  leading: const Icon(Icons.document_scanner_outlined),
                  title: const Text('Scan a receipt'),
                  subtitle: const Text('Use your camera or photo library.'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _scanReceipt();
                  },
                ),
                ListTile(
                  key: const Key('add-manually-action'),
                  leading: const Icon(Icons.edit_note_rounded),
                  title: const Text('Add manually'),
                  subtitle: const Text('Enter amount, merchant and card.'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _openManualTransaction();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openManualTransaction() {
    final workspace = ref.read(initialSetupControllerProvider).workspace;
    if (workspace == null) {
      AppToast.showError(context, 'Could not load your workspace.');
      return;
    }

    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => TransactionEditorScreen(
          profileId: workspace.localId,
          cards: workspace.cards,
        ),
      ),
    );
  }

  Future<void> _scanReceipt() async {
    var scanningDialogVisible = false;
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: ui.AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose receipt image',
                style: Theme.of(sheetContext).textTheme.titleLarge,
              ),
              const SizedBox(height: ui.AppSpacing.sm),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Take a photo'),
                onTap: () => Navigator.pop(sheetContext, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from library'),
                onTap: () => Navigator.pop(sheetContext, ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );
    if (source == null || !mounted) return;

    try {
      final image = await ImagePicker().pickImage(
        source: source,
        maxWidth: 2400,
        maxHeight: 3200,
        imageQuality: 92,
        requestFullMetadata: false,
      );
      if (image == null || !mounted) return;

      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const _ScanningReceiptDialog(),
      );
      scanningDialogVisible = true;
      final scan = await ref
          .read(receiptScanControllerProvider)
          .scan(
            bytes: await image.readAsBytes(),
            fileName: image.name,
            contentType: _receiptContentType(image),
          );
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      scanningDialogVisible = false;

      final workspace = ref.read(initialSetupControllerProvider).workspace;
      if (workspace == null) {
        AppToast.showError(context, 'Could not load your workspace.');
        return;
      }
      await Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (_) => TransactionEditorScreen(
            profileId: workspace.localId,
            cards: workspace.cards,
            initialReceiptScan: scan,
          ),
        ),
      );
    } on ReceiptScanException catch (error) {
      if (!mounted) return;
      if (scanningDialogVisible) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      AppToast.showError(context, error.message);
    } on Object {
      if (!mounted) return;
      if (scanningDialogVisible) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      AppToast.showError(context, 'Could not open or scan this receipt.');
    }
  }

  String _receiptContentType(XFile image) {
    final mimeType = image.mimeType?.toLowerCase();
    if (mimeType == 'image/png' ||
        mimeType == 'image/webp' ||
        mimeType == 'image/jpeg') {
      return mimeType!;
    }
    final name = image.name.toLowerCase();
    if (name.endsWith('.png')) return 'image/png';
    if (name.endsWith('.webp')) return 'image/webp';
    return 'image/jpeg';
  }

  @override
  Widget build(BuildContext context) {
    final workspace = ref.watch(initialSetupControllerProvider).workspace;

    if (workspace == null) {
      if (!_isNavigatingToError) {
        _isNavigatingToError = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) {
            return;
          }

          Navigator.of(context).pushReplacementNamed(
            AppRoutes.error,
            arguments: const ErrorScreenArguments(
              title: 'We couldn\'t load your workspace',
              description:
                  'Your workspace is missing or unavailable. Return to '
                  'sign in and set up CardPilot again.',
              actionLabel: 'Back to sign in',
              actionRoute: AppRoutes.signIn,
            ),
          );
        });
      }

      return const SizedBox.shrink();
    }

    final pages = [
      HomePage(workspace: workspace),
      CardsPage(workspace: workspace),
      TransactionsPage(workspace: workspace),
      ProfilePage(workspace: workspace),
    ];
    final pageIndex = switch (_selectedIndex) {
      0 => 0,
      1 => 1,
      3 => 2,
      4 => 3,
      _ => 0,
    };

    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: pageIndex, children: pages),
      bottomNavigationBar: ui.AppFloatingNavigationBar(
        key: const Key('home-navigation-bar'),
        items: _navigationItems,
        selectedIndex: _selectedIndex,
        onSelected: _selectDestination,
      ),
    );
  }
}

class _ScanningReceiptDialog extends StatelessWidget {
  const _ScanningReceiptDialog();

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: Row(
        children: [
          SizedBox.square(
            dimension: 24,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
          SizedBox(width: ui.AppSpacing.md),
          Expanded(child: Text('Scanning receipt...')),
        ],
      ),
    );
  }
}
