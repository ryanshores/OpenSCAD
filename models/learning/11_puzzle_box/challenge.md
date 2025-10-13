🎯 Challenge: “Parametric Puzzle Box”

Goal: Create a small puzzle box with interlocking parts, entirely in SolidPython.

Features your box should have:
	1.	Box body
	•	Rectangular or square.
	•	Wall thickness = thickness parameter.
	•	Outer dimensions: length, width, height.
	2.	Sliding lid
	•	The lid should slide into the body, not sit on top.
	•	Create guides or rails inside the walls for the lid to slide.
	3.	Knob or handle
	•	Add a small cylinder or sphere on the lid as a handle.
	4.	Optional “window” cutout
	•	Cut a simple shape (circle, star, polygon) in one wall for decoration or to see the contents.
	5.	Parametric
	•	All sizes (length, width, height, wall thickness, handle size) should be controlled by function parameters.
	•	Bonus: Make the lid slide direction and box orientation changeable with parameters.
	6.	Optional extra challenge
	•	Add fillets or chamfers to edges (like OpenSCAD’s offset + minkowski trick, or SolidPython/OCCT fillets if you feel brave).

⸻

Example function signature (for inspiration)
```python
def puzzle_box(length=60, width=40, height=30, thickness=3, lid_height=5, handle_radius=5):
    # TODO: implement
    pass
```

Hints
	•	Use difference() to cut out the hollow inside.
	•	Use translate() for positioning the lid and handle.
	•	linear_extrude() or cube() for main shapes.
	•	Keep it modular: maybe create helper functions like box_body(), lid(), handle().
	•	Make it parametric: you should be able to call puzzle_box(length=80, width=50) and have everything scale correctly.