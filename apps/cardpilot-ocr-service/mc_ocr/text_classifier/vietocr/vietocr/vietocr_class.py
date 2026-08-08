from pathlib import Path

from PIL import Image

from vietocr.tool.config import Cfg
from vietocr.tool.predictor import Predictor


class Classifier_Vietocr:
    def __init__(self, ckpt_path, gpu=None):
        project = Path(__file__).resolve().parents[1]
        config = Cfg.load_config(
            project / "config/base.yml", project / "config/vgg-seq2seq.yml"
        )
        config["weights"] = ckpt_path
        config["cnn"]["pretrained"] = False
        config["device"] = "cuda:{}".format(gpu) if gpu is not None else "cpu"
        config["predictor"]["beamsearch"] = False
        self.model = Predictor(config)

    def inference(self, images, debug=False):
        values, probabilities = [], []
        for image in images:
            value, probability = self.model.predict(Image.fromarray(image), True)
            values.append(value)
            probabilities.append(probability)
        return values, probabilities
