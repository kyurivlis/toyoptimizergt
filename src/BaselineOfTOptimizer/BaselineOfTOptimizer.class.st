Class {
	#name : #BaselineOfTOptimizer,
	#superclass : #BaselineOf,
	#category : #BaselineOfTOptimizer
}

{ #category : #loading }
BaselineOfTOptimizer class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'toyoptimizergt' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfTOptimizer >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'TOptimizer'
		]
]
