Class {
	#name : #SSAValue,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #TOptimizer
}

{ #category : #accessing }
SSAValue >> addVal: scope [ 
]

{ #category : #accessing }
SSAValue >> addVal: v scope: scope [
	v isSSAValue ifTrue: [v asScope: scope]
		ifFalse: [scope nextPut: v]
]

{ #category : #accessing }
SSAValue >> asScope [
	^OrderedCollection streamContents: [:ws | self asScope: ws]
]

{ #category : #accessing }
SSAValue >> asScope: scope [
	scope nextPut: self.
	self addVal: scope
]

{ #category : #accessing }
SSAValue >> name [
	^name
]
