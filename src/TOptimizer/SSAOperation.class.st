Class {
	#name : #SSAOperation,
	#superclass : #SSAValue,
	#instVars : [
		'args'
	],
	#category : #TOptimizer
}

{ #category : #accessing }
SSAOperation >> addVal: scope [
	args do: [:a|self addVal: a scope: scope]
]
