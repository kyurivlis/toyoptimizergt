Class {
	#name : #SSAConstant,
	#superclass : #SSAValue,
	#instVars : [
		'version',
		'value'
	],
	#category : #TOptimizer
}

{ #category : #accessing }
SSAConstant >> asEdges [
	^ self asEdges: Dictionary new
]

{ #category : #accessing }
SSAConstant >> asEdges: dict [
	dict at: self put: value.
	value isSSAValue ifTrue: [value asEdges: dict].
	^dict
]

{ #category : #accessing }
SSAConstant >> asScope [
	^OrderedCollection streamContents: [:ws | self asScope: ws]
]

{ #category : #accessing }
SSAConstant >> asScope: writeStream [
	writeStream nextPut: self.
	value isSSAValue 
		ifTrue: [value asScope: writeStream]
		ifFalse: [writeStream nextPut: value]
]

{ #category : #accessing }
SSAConstant >> assignmentErrorText [
	^ 'second dynamic assignment'
]

{ #category : #accessing }
SSAConstant >> bar [
	<gtExample>
	self name: #bar value: SSAConstant new foo1;
		assert: self asScope size equals: 3.
]

{ #category : #accessing }
SSAConstant >> foo [
	<gtExample>
	self name: #foo;
		assert: name equals: #foo;
		assert:value isNil;
		assert: version equals: 1
]

{ #category : #accessing }
SSAConstant >> foo1 [
	<gtExample>
	^ self foo value: 1; assert: value equals: 1
]

{ #category : #accessing }
SSAConstant >> gtTreeFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Tree';
		priority: 1;
		painting: [:m | self valueTree: m]
]

{ #category : #accessing }
SSAConstant >> name: aName [
	self name: aName value: nil 
]

{ #category : #initialize }
SSAConstant >> name: aName value: aValue [
	self name: aName value: aValue version: 1 
]

{ #category : #initialize }
SSAConstant >> name: aName value: aValue version: anInteger [ 
	name:=aName asSymbol.
	value:=aValue.
	version:=anInteger
]

{ #category : #accessing }
SSAConstant >> nodeShape: x [
^BlTextElement new
	text: (x isSSAValue
		ifTrue: [x name]
		ifFalse: [x]) asRopedText
]

{ #category : #accessing }
SSAConstant >> printOn: aStream [
	super printOn: aStream.
	aStream space; nextPutAll: (name ifNil: [''] ifNotNil: [name])
]

{ #category : #accessing }
SSAConstant >> secondAssignment [
	<gtExample>
	[ self foo1 value: 2 ] onErrorDo: [ :x |
		 self assert: x messageText
		 	 equals: self assignmentErrorText.
		   ^x signaler assert: value equals: 1]
]

{ #category : #accessing }
SSAConstant >> value [
	^value
]

{ #category : #accessing }
SSAConstant >> value: aValue [
	value isNotNil ifTrue: [self error: self assignmentErrorText].
	value:= aValue
]

{ #category : #accessing }
SSAConstant >> valueTree: m [
	m nodes
		shape: [:x | self nodeShape: x];
		with: self asScope.
	m edges
		fromCenterBottom;
		toCenterTop;
	    connectFrom: [ :x | x isSSAValue ifTrue: [ x value ] ] to: [ :x | x ].
	m layout tree.
	^ m
]

{ #category : #accessing }
SSAConstant >> valueTreeConnectFrom: x [
	x isSSAValue ifTrue: [^(x value)] ifFalse: [^nil]
]
