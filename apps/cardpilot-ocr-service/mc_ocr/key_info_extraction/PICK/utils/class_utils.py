# -*- coding: utf-8 -*-
# @Author: Wenwen Yu
# @Created Time: 7/8/2020 9:26 PM


from collections import Counter, defaultdict
from pathlib import Path

from . import entities_list


class ClassVocab:

    def __init__(self, classes, specials=None, specials_first=True, **kwargs):
        '''
        convert key to index(stoi), and get key string by index(itos)
        :param classes: list or str, key string or entity list
        :param specials: list, speical tokens except <unk> (default: {['<pad>', '<unk>']})
        :param kwargs:
        '''
        cls_list = None
        if isinstance(classes, str):
            cls_list = list(classes)
        if isinstance(classes, Path):
            p = Path(classes)
            if not p.exists():
                raise RuntimeError('Key file is not found')
            with p.open(encoding='utf8') as f:
                classes = f.read()
                classes = classes.strip()
                cls_list = list(classes)
        elif isinstance(classes, list):
            cls_list = classes
        specials = specials or ['<pad>', '<unk>']
        counter = Counter(cls_list)
        for token in specials:
            counter.pop(token, None)

        # Match torchtext 0.6 Vocab ordering so pretrained embedding indexes stay stable.
        words_and_frequencies = sorted(counter.items(), key=lambda item: item[0])
        words_and_frequencies.sort(key=lambda item: item[1], reverse=True)
        min_freq = max(kwargs.get('min_freq', 1), 1)
        max_size = kwargs.get('max_size')
        words = [word for word, frequency in words_and_frequencies if frequency >= min_freq]
        if max_size is not None:
            words = words[:max_size]

        self.itos = list(specials) + words if specials_first else words + list(specials)
        self.special_count = len(specials)
        self.unk_index = self.itos.index('<unk>') if '<unk>' in self.itos else 0
        self.stoi = defaultdict(lambda: self.unk_index)
        self.stoi.update({token: index for index, token in enumerate(self.itos)})

    def __getitem__(self, token):
        return self.stoi[token]

    def __len__(self):
        return len(self.itos)


def entities2iob_labels(entities: list):
    '''
    get all iob string label by entities
    :param entities:
    :return:
    '''
    tags = []
    for e in entities:
        tags.append('B-{}'.format(e))
        tags.append('I-{}'.format(e))
    tags.append('O')
    return tags


keys_vocab_cls = ClassVocab(
    Path(__file__).parent.joinpath('keys_vietnamese.txt'), specials_first=False
)
iob_labels_vocab_cls = ClassVocab(
    entities2iob_labels(entities_list.Entities_list), specials_first=False
)
entities_vocab_cls = ClassVocab(entities_list.Entities_list, specials_first=False)
