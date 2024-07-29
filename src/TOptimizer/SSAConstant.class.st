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
SSAConstant >> assignmentErrorText [
	^ 'second dynamic assignment'
]

{ #category : #accessing }
SSAConstant >> foo [
	<gtExample>
	self name: #foo; assert: name equals: #foo; assert: value isNil; assert: version equals: 1
]

{ #category : #accessing }
SSAConstant >> foo1 [
	<gtExample>
	self foo value: 1; assert: value equals: 1
]

{ #category : #initialize }
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
SSAConstant >> printOn: aStream [
	super printOn: aStream.
	aStream space; nextPutAll: name
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
SSAConstant >> value: aValue [
	value isNotNil ifTrue: [self error: self assignmentErrorText].
	value:= aValue
]
