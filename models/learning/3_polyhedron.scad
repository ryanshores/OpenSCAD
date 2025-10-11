
L = 20; // the length of the square base sides
H = 10; // the height of the square pyramid

// points around the base
A = [-L/2, L/2, 0];
B = [L/2, L/2, 0];
C = [L/2, -L/2, 0];
D = [-L/2, -L/2, 0];
// the top point (apex)
E = [0, 0, H];

polyhedron(
    points=[A, B, C, D, E],
    faces=[
        [0, 1, 4],
        [1, 2, 4],
        [2, 3, 4],
        [0, 3, 4],
        [0, 1, 2, 3]
    ]
);