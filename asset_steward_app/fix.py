import sys

path = r'E:\Developments\FlutterProject\AssetSteward\asset_steward_app\lib\features\assets\data\datasources\assets_remote_ds.dart'
with open(path, 'r', encoding='utf-8') as f:
    text = f.read()
text = text.replace(r"\'", "'")
text = text.replace(r"\n", "\n")
with open(path, 'w', encoding='utf-8') as f:
    f.write(text)

path2 = r'E:\Developments\FlutterProject\AssetSteward\asset_steward_app\lib\features\assets\data\repositories\assets_repository.dart'
with open(path2, 'r', encoding='utf-8') as f:
    text2 = f.read()
text2 = text2.replace(r"\n", "\n")
with open(path2, 'w', encoding='utf-8') as f:
    f.write(text2)
