		addi $s1, $zero, 0
		addi $t1, $zero, 0
		addi $s7, $zero, 128
		
		# Carrega todos os valores na memória
wrloop:		addi $s1, $s1, 1
		addi $t1, $t1, 4
		sw $s1, 0x10010000($t1)
		blt $s1, $s7, wrloop
		
		# Inicializa no primeiro valor
		addi $s1, $zero, 2
		addi $t1, $zero, 8
		
		# Inicializa o contador
primeloop:	add $s2, $s1, $zero
		add $t2, $t1, $zero
		# Pega o próximo valor
zeroloop:	add $s2, $s2, $s1
		add $t2, $t2, $t1
		blt $s7, $s2, nextloop
		# Seta o valor como zero
		sw $zero, 0x10010000($t2)
		blt $s2, $s7, zeroloop
		
		# Seleciona o próximo valor não nulo da memória
nextloop:	addi $s1, $s1, 1
		addi $t1, $t1, 4
		blt $s7, $s1, out		# Se passou do limite, terminou o programa
		lw $s3, 0x10010000($t1)
		beq $s3, $zero, nextloop	# Se for zero, pega o próximo
		b primeloop
		
out:		