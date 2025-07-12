function angle_greater(ang1, ang2) {
	return (angle_difference(ang1, ang2) >= 0);
}
function angle_lesser(ang1, ang2) {
	return (angle_difference(ang1, ang2) <= 0);
}

function angle_in_range(ang1, range_low, range_top) {
	return(angle_greater(ang1, range_low) and angle_lesser(ang1, range_top));
}