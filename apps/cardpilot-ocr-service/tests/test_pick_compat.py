import importlib.util
import sys
import types
from pathlib import Path

import pytest

PICK_ROOT = Path(__file__).resolve().parents[1] / "mc_ocr/key_info_extraction/PICK"
PACKAGE_NAME = "pick_test_utils"
package = types.ModuleType(PACKAGE_NAME)
package.__path__ = [str(PICK_ROOT / "utils")]
sys.modules[PACKAGE_NAME] = package
spec = importlib.util.spec_from_file_location(
    f"{PACKAGE_NAME}.class_utils", PICK_ROOT / "utils/class_utils.py"
)
class_utils = importlib.util.module_from_spec(spec)
sys.modules[spec.name] = class_utils
spec.loader.exec_module(class_utils)
ClassVocab = class_utils.ClassVocab


def test_vocab_matches_torchtext_legacy_ordering():
    vocab = ClassVocab(["b", "a", "b", "c"], specials_first=False)

    assert vocab.itos == ["b", "a", "c", "<pad>", "<unk>"]
    assert vocab["missing"] == vocab.stoi["<unk>"]


def test_numericalize_sequences_pads_and_returns_lengths():
    np = pytest.importorskip("numpy")
    from data_utils.documents import numericalize_sequences

    vocab = ClassVocab(["a", "b"], specials_first=False)

    values, lengths = numericalize_sequences([["a", "b"], ["b"]], vocab)

    np.testing.assert_array_equal(lengths, [2, 1])
    np.testing.assert_array_equal(
        values,
        [
            [vocab["a"], vocab["b"]],
            [vocab["b"], vocab["<pad>"]],
        ],
    )
