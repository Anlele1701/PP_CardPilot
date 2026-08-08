import math

import cv2
import numpy as np
from scipy.cluster.vq import kmeans, vq


def _coordinates(box_data):
    return box_data["coors"] if isinstance(box_data, dict) else box_data


def _horizontal_angle(box):
    points = np.asarray(box, dtype="float32").reshape(-1, 2)
    first = points[1] - points[0]
    second = points[2] - points[1]
    edge = first if np.linalg.norm(first) > np.linalg.norm(second) else second
    return math.degrees(math.atan2(edge[1], edge[0]))


def drop_box(boxes, drop_gap=(0.5, 2), debug=False):
    result = []
    for item in boxes:
        width, height = cv2.minAreaRect(
            np.asarray(_coordinates(item), dtype="int32").reshape(-1, 1, 2)
        )[1]
        if height and not min(drop_gap) < width / height < max(drop_gap):
            result.append(item)
    return result


def _largest_angle_cluster(angles, threshold=45):
    absolute = np.abs(np.asarray(angles))
    if len(absolute) > 1 and absolute.max() - absolute.min() > threshold:
        centroids, _ = kmeans(absolute, 2)
        indexes, _ = vq(absolute, centroids)
        counts = np.bincount(indexes)
        return [angle for angle, index in zip(angles, indexes) if index == counts.argmax()]
    return angles


def get_mean_horizontal_angle(boxes, debug=False, cluster=True):
    if not boxes:
        return 0
    angles = [_horizontal_angle(_coordinates(item)) for item in boxes]
    if cluster:
        angles = _largest_angle_cluster(angles)
    normalized = []
    for angle in angles:
        normalized.append(180 - angle + 90 if angle >= 0 else abs(angle) - 90)
    return float(np.mean(normalized) - 90)


def filter_90_box(boxes, debug=False, thresh=45):
    if not boxes:
        return []
    angles = [_horizontal_angle(_coordinates(item)) for item in boxes]
    absolute = np.abs(np.asarray(angles))
    if len(absolute) <= 1 or absolute.max() - absolute.min() <= thresh:
        return boxes
    centroids, _ = kmeans(absolute, 2)
    indexes, _ = vq(absolute, centroids)
    keep = np.bincount(indexes).argmax()
    return [item for item, index in zip(boxes, indexes) if index == keep]
