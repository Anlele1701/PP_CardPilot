import yaml


class Cfg(dict):
    def __init__(self, config_dict):
        super().__init__(**config_dict)
        self.__dict__ = self

    @staticmethod
    def load_config(base_config_path, config_path):
        with open(base_config_path, encoding="utf-8") as source:
            config = yaml.safe_load(source)
        with open(config_path, encoding="utf-8") as source:
            config.update(yaml.safe_load(source))
        return Cfg(config)
