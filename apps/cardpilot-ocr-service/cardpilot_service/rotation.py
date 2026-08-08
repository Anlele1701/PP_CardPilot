import cv2
import numpy as np
import torch
from PIL import Image, ImageOps
from torchvision import transforms

from mc_ocr.rotation_corrector.model.mobilenetv3 import mobilenetv3


class ReceiptRotationClassifier:
    labels = ("0", "180")

    def __init__(self, weight_path):
        self.device = torch.device("cpu")
        self.model = mobilenetv3(n_class=2, dropout=0.2, input_size=64)
        self.model.load_state_dict(torch.load(str(weight_path), map_location=self.device))
        self.model.to(self.device).eval()
        self.transform = transforms.Compose(
            [
                _PadToRatio((64, 192)),
                transforms.Resize((64, 192), interpolation=Image.NEAREST),
                transforms.ToTensor(),
                transforms.Normalize(
                    mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]
                ),
            ]
        )

    def inference(self, image, debug=False):
        if isinstance(image, np.ndarray):
            image = Image.fromarray(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
        tensor = self.transform(image).view(1, 3, 64, 192).to(self.device)
        with torch.no_grad():
            probabilities = torch.softmax(self.model(tensor), dim=1)[0]
        index = int(probabilities.argmax().item())
        return image, (self.labels[index], float(probabilities[index].item()))


class _PadToRatio:
    def __init__(self, target_size, fill=(255, 255, 255)):
        self.target_height, self.target_width = target_size
        self.fill = fill

    def __call__(self, image):
        width, height = image.size
        target_ratio = self.target_height / self.target_width
        if height / width < target_ratio:
            width = int(round(self.target_height / (height / width)))
            return image.resize((width, self.target_height))
        target_width = height / target_ratio
        padding = int(round((target_width - width) / 2))
        return ImageOps.expand(image, border=(padding, 0, padding, 0), fill=self.fill)
