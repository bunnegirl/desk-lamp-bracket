plateThickness = 3;
plateScrewSpacing = 30;
plateScrewDiameter = 3;
mountThickness = 3;
mountDiameter = 12;
mountHeight = 40;

plateScrewRadius = plateScrewDiameter / 2;
mountRadius = mountDiameter / 2;

$fn = 50;

module screw_outer()
{
    translate([0, plateScrewSpacing, 0])
        circle(plateScrewRadius + plateThickness);
}

module screw_inner()
{
    translate([0, plateScrewSpacing, 0])
        circle(plateScrewRadius);
}

module plate()
{
    difference()
    {
        hull()
        {
            screw_outer();
            rotate([0, 0, 360 / 3])
                screw_outer();
            rotate([0, 0, -360 / 3])
                screw_outer();
        }

        screw_inner();
        rotate([0, 0, 360 / 3])
            screw_inner();
        rotate([0, 0, -360 / 3])
            screw_inner();
    }
}

module mount()
{
    baseRadius = (mountRadius + plateScrewSpacing) / 4;

    translate([mountRadius, 0, 0])
        square([mountThickness, mountHeight]);

    difference()
    {
        translate([mountRadius + mountThickness, 0, 0])
            square(baseRadius);

        translate([baseRadius + mountRadius + mountThickness, baseRadius, 0])
            circle(baseRadius);
    }
}

linear_extrude(plateThickness)
    plate();

translate([0, 0, plateThickness])
    rotate_extrude(angle = 360)
    mount();