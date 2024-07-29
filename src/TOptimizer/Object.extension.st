Extension { #name : #Object }

{ #category : #'*TOptimizer' }
Object >> isSSAValue [
	^ self isKindOf: SSAValue
]
