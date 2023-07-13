.text

.global distance3d
.type distance3d, @function
distance3d:
	mulss %xmm0, %xmm0
	mulss %xmm1, %xmm1
	mulss %xmm2, %xmm2
	addss %xmm1, %xmm0
	addss %xmm2, %xmm0
	sqrtss %xmm0, %xmm0
	ret
