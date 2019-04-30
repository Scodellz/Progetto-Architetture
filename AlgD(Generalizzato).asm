.data

	inputBuffer: 		.asciiz	"Prova"
	outputBuffer:		.space	255
	
.text

read:
	la	$a2, inputBuffer			# Metto il buffer di input in $a2
	la	$a3, outputBuffer		# Carico il buffer che conterrà il messaggio da restituire in $a3
	move	$t0, $zero			# Inizializzo contatore degli elementi della stringa a 0
	
counter:						# Metodo che conta quanti elementi sono presenti nel buffer
	lbu	$t1, ($a2)			# Carico il carattere puntato in $t1
	beqz	$t1, endPointer			# Se sono arrivato alla fine della stringa il metodo termina
	addi	$t0, $t0, 1			# Altrimenti aumento il contatore di 1
	addi	$a2, $a2, 1			# Scorro alla posizione successiva del buffer
	
	j 	counter				# Inizio un nuovo ciclo

endPointer:
	addi	$a2, $a2, -1			# Dato che il il puntatore e' fuori dal buffer, lo faccio tornare
						# indietro di una posizione
	move	$s0, $t0				# Dato che e' il numero degli elementi rimarra' invariato lo salvo in $s0
	move	$t0, $zero			# Reinizializzo $t0 per contare il numero di elementi che verranno inseriti

reversal:					# Metodo di inversione				
	beq	$t0, $s0, exitInvert		# Se il numero dei caratteri inseriti è pari alla lunghezza del buffer
						# allora posso uscire dalla procedura	
	lbu	$t1, ($a2)			# Altrimenti metto in $t1 l'elemento del buffer di input
	sb	$t1, ($a3)			# e lo salvo nel buffer di uscita

	subi	$a2, $a2, 1			# Vado al carattere precedente del buffer di input
	addi	$a3, $a3, 1			# Scorro alla posizione successiva del buffer di output
	addi	$t0, $t0, 1			# Aumento di 1 il contatore dei caratteri inseriti
	
	j 	reversal

exitInvert:
	jr	$ra