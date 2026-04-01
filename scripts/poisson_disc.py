import math
import random
from typing import Tuple, List, Dict


class PoissonDisc:
    def __init__(self, width: int, height: int, count: int = 30, min_dist: float = 2.0):
        self.count = count
        self.side_length = min_dist / math.sqrt(2)
        self.width = width
        self.height = height
        self.min_dist = min_dist
        self.nx, self.ny = (
            int(width / self.side_length) + 1,
            int(height / self.side_length) + 1,
        )
        self.samples = []
        self._reset()

    def get_samples(self):
        # single random point to start with
        pt = (random.uniform(0, self.width), random.uniform(0, self.height))
        self.samples = [pt]
        # first sample will be indexed at 0
        self.grid[self._get_cell_coord(pt)] = 0
        # this starting point is "active", meaning we will look for points in its neigbour
        active = [0]

        while active:
            # reference point
            rand_sample_index = random.choice(active)
            ref_point = self.samples[rand_sample_index]
            # generate a new point
            point = self._get_point(ref_point)
            if point:
                self.samples.append(point)
                n_samples = len(self.samples) - 1
                active.append(n_samples)
                self.grid[self._get_cell_coord(point)] = n_samples
            else:
                active.remove(rand_sample_index)

        return self.samples

    def _reset(self):
        # A list of coordinates in the grid of cells
        self.coords_set = [(ix, iy) for ix in range(self.nx) for iy in range(self.ny)]
        # dict of all coords
        # key is cell coord
        # value is index in the samples list, None means its not occupied
        self.grid: Dict[Tuple[int, int], None | int] = {
            coords: None for coords in self.coords_set
        }

    def _get_cell_coord(self, cell):
        return (
            int(cell[0] // self.side_length),
            int(cell[1] // self.side_length),
        )

    def _get_neighbours(
        self,
        coord: Tuple[int, int],
    ) -> List[int]:
        """
        Returns coords of cells around the given coord
                 000
                00000
                00X00
                00000
                 000
        """
        # set of all neighbours indices
        neighbours_dxdy = (
            (-1, -2),
            (0, -2),
            (1, -2),
            (-2, -1),
            (-1, -1),
            (0, -1),
            (1, -1),
            (2, -1),
            (-2, 0),
            (-1, 0),
            (1, 0),
            (2, 0),
            (-2, 1),
            (-1, 1),
            (0, 1),
            (1, 1),
            (2, 1),
            (-1, 2),
            (0, 2),
            (1, 2),
            (0, 0),
        )

        # neighbour samples
        neighbours = []

        for dx, dy in neighbours_dxdy:
            neighbour_coords = (coord[0] + dx, coord[1] + dy)
            # make sure to not go beyond the grid
            if not (
                (0 <= neighbour_coords[0] < self.nx)
                and (0 <= neighbour_coords[1] < self.ny)
            ):
                continue

            neighbour_cell = self.grid[neighbour_coords]
            if neighbour_cell is not None:
                neighbours.append(neighbour_cell)

        return neighbours

    def _is_point_valid(
        self,
        coord: Tuple[int, int],
    ):
        """
        check if there's any sample nearer than least distance in the immediate neighbour
        """
        cell_coord = self._get_cell_coord(coord)
        for neigbour in self._get_neighbours(cell_coord):
            nearby = self.samples[neigbour]
            dist = math.sqrt(
                ((nearby[0] - coord[0]) ** 2) + ((nearby[1] - coord[1]) ** 2)
            )
            if dist < self.min_dist:
                # point too close
                return False

        return True

    def _get_point(self, ref_pt):
        """
        Tries to find a suitable point for sampling
        """
        for _ in range(self.count):
            rho = math.sqrt(random.uniform(self.min_dist**2, 4 * self.min_dist**2))
            theta = random.uniform(0, 2 * math.pi)
            pt = ref_pt[0] + rho * math.cos(theta), ref_pt[1] + rho * math.sin(theta)
            if not (0 <= pt[0] < self.width and 0 <= pt[1] < self.height):
                continue
            if self._is_point_valid(pt):
                return pt
        return False
