---
title:  padmet package - Documentation
author: Meziane AITE
date: 2017-04-20
version: 2.4
geometry: margin=2cm
---
\newpage

################################################################################

## Description
@padmet Version: 2.4
author: meziane aite (meziane.aite@inria.fr)
Python 2.7

Description:
The PADMet package allows conciliating genomics and metabolic network information used to produce a genome-scale constraint-based metabolic model within a database that traces all the reconstruction process steps. It allows representing the metabolic model in the form of a Wiki containing all the used/traced information. Other standard outputs are made available with the package. 
The main concept underlying PADMet-Package is to provide solutions that ensure the consistency, the internal standardization and the reconciliation of the information used within any workflow that combines several tools involving metabolic networks reconstruction or analysis. The PADMet package is at the core of the AuReMe workflow, dedicated to the primary reconstruction of genome-scale metabolic networks from raw data. It allows the study of organisms for which few experimental data are available. Its main feature is to undergo the reconstruction of the metabolic network by combining several
heterogeneous knowledge and data sources, including the information reported by several scaffold metabolic networks for cousin species.


## Installation

From pip:
	pip install padmet

From git:
	git clone https://gitlab.inria.fr/maite/padmet.git
	make install (from git/padmet)


## Architecture


    .
    ├── LICENSE
    ├── Makefile
    ├── MANIFEST.in
    ├── README.md
    ├── setup.cfg
    ├── setup.py
    └──  padmet
        ├── __init__.py
        ├── aspGenerator.py
        ├── node.py
        ├── padmetRef.py
        ├── padmetSpec.py
        ├── policy.py
        ├── README.md
        ├── relation.py
        ├── sbmlGenerator.py
        ├── sbmlPlugin.py
        └── wikiGenerator.py

## Documentation
node.py:
	Description:
	Define the class Node used in padmet.

	class Node:
	    """
	    A Node represent an element in a metabolic network (eg: compound, reaction)
	    A Node contains 3 attributs:
		_type: The type of the node (eg: 'reaction' or 'pathway')
		_id: the identifier of the node (eg: 'rxn-45)
		_misc: A dictionnary of miscellaneous data, k = tag of the data, v = list of values
		(eg: {'DIRECTION':[REVERSIBLE]})
	    """
	    __init__(self, _type, _id, misc = None):
		"""
		@param _type: The type of the node ('reaction','pathway')
		@param _id: the identifier of the node ('rxn-45)
		@param _misc: A dictionnary of miscellaneous data ({'DIRECTION':[REVERSIBLE]})
		@type _type, _id: str
		@type misc: dict
		@return: _
		@rtype: None
		"""
	    
	    toString(self):
		"""
		This function is used to stock the information relative to the node
		in a padmet file.
		@return: string with all data sep by tab' ex: reaction\tRXN0..
		@rtype: str
		"""
relation.py
Description:
Define the class Relation used in padmet.

	class Relation:
	    """
	    A Relation represent an link between two elements (node) in a metabolic network
	    eg: RXN-1 consumes CPD-1
	    A Relation contains 4 attributs:
		_type: The type of the relation (eg: 'consumes' or 'produces')
		id_in: the identifier of the node corresponding to the subject of the relation (eg: 'RXN-1)
		id_out: the identifier of the node corresponding to the object of the relation (eg: 'CPD-1)
		_misc: A dictionnary of miscellaneous data, k = tag of the data, v = list of values
		(eg: {'STOICHIOMETRY':[1.0]})
	    """
	    __init__(self, id_in, _type, id_out, misc = None):
		"""
		@param _type: The type of the relation (eg: 'consumes' or 'produces')
		@param id_in: the identifier of the node corresponding to the subject of the relation ('RXN-1)
		@param id_out: the identifier of the node corresponding to the object of the relation ('CPD-1)
		@param _misc: A dictionnary of miscellaneous data (eg: {'STOICHIOMETRY':[1.0]})
		@type _type, _id: str
		@type misc: dict
		@return: _
		@rtype: None
		"""

	    toString(self):
		"""
		This function is used to stock the information relative to the node
		in a padmet file.
		@return: string with all data sep by tab' ex: reaction\tRXN0..
		@rtype: str
		"""

	    compare(self,relation):
		"""
		compare 2 relations. return True or False
		@param relation: the relation to compare
		@type relation: Relation
		@return: True,False
		@rtype: bool
		"""

policy.py
Description:
Define a policy in padmet object.

	class Policy:
	    """
	    A Policy define the types of relations, nodes in a network.
	    A policy contains 3 attributs:
		policy_in_array: Is a list of list of arcs (eg: [['reaction','consumes','compounds'],['reaction','produces','compounds']])
		class_of_node: Is a set of all the type of nodes represented in the network (eg: set(reaction, compound))
		type_of_arc: Is a dictionnary of all the types of arcs represented in the network (eg: {reaction:[consumes,compounds]})
	    """

	    __init__(self,policy_in_array = None):
		"""
		@param policy_in_array: Is a list of list of arcs (eg: [['reaction','consumes','compounds'],['reaction','produces','compounds']])
		@type policy_in_array: list
		@return: _
		@rtype: None
		"""
		    
	    setPolicyInArray(self,policy_in_array):
		"""
		From policy_in_array, set class_of_node and type_of_arc
		@param policy_in_array: Is a list of list of arcs (eg: [['reaction','consumes','compounds'],['reaction','produces','compounds']])
		@type policy_in_array: list
		@return: _
		@rtype: None
		"""

	    getPolicyInArray(self):
		"""
		return policy_in_array
		@return: self.policy_in_array
		@rtype: list
		"""
		    
	    _setClassOfNode(self):
		"""
		From self.policy_in_array set class_of_node
		@return: _
		@rtype: None
		"""

	    getClassOfNode(self):
		"""
		return class_of_node
		@return: self.class_of_node
		@rtype: set
		"""

	    _setTypeOfArc(self):
		"""
		From self.policy_in_array and self.class_of_node set type_of_arc
		@return: _
		@rtype: None
		"""

	    getTypeOfArc(self):
		"""
		return class_of_node
		@return: self.class_of_node
		@rtype: set
		"""

padmetRef.py
Description:
PadmetRef is an object representing a DATABASE of metabolic network.

	class PadmetRef:
	    """
	    PadmetRef is an object representing a DATABASE of metabolic network.
	    Contains <Policy>, <Node> and <Relation>
	    The policy defines the way Node and Relation are associated
	    A node is an Object that contains information about an element of the network 
	    (can be a pathway, reaction...).
	    A realtion defines how two nodes are connected. In a relation there is 
	    a node "in" and a node "out". (reactionX'in' consumes metaboliteX'out')
	    PadmetRef contains 3 attributs: 
		dicOfNode: a dictionary of node: key=Node's unique id / value = <Node>
		dicOfRelationIn: a dictionnary of relation with: key= nodeIN id / value = list of <relation>
		dicOfRelationOut: a dictionnary of relation with: key= nodeOut id / value = list of <relation>
		policy: a <policy>
		info: a dictionnary of informations about the network, the database used...
		This dictionnary is always represented in the header of a padmet file
	    """
	#==============================================================================
	# Constructor / getter            
	#==============================================================================
		
	    setInfo(self,source):
		"""
		All the information printed in the header of a padmet stocked in a dict.
		{"metacyc":{version:XX,...},"ecocyc":{...}...}
		set Info from a dictionnary or copying from an other padmet
		@param source: may be a dict or an other padmet from where will be copied the info
		@tyme source: dict or Padmet
		"""

	    setPolicy(self,source):
		"""
		Set policy from a list or copying from an other padmet
		@param source: may be a list or an other padmet from where will be copied the policy
		@type source: list or Padmet
		"""

	    setDicOfNode(self,source):
		"""
		Set dicOfNode from a dict or copying from an other padmet
		@param source: may be a dict or an other padmet from where will be copied the dicOfNode
		@type source: dict or Padmet
		"""

	    setdicOfRelationIn(self,source):
		"""
		Set dicOfRelationIn from a dict or copying from an other padmet
		@param source: may be a dict or an other padmet from where will be copied the dicOfRelationIn
		@type source: dict or Padmet
		@rtype: None
		"""

	    setdicOfRelationOut(self,source):
		"""
		Set dicOfRelationOut from a dict or copying from an other padmet
		@param source: may be a dict or an other padmet from where will be copied the dicOfRelationIn
		@type source: dict or Padmet
		@rtype: None
		"""

	    getAllRelation(self):
		"""
		return a set of all relations
		@rtype: set
		"""

	    loadGraph(self, padmet_file):
		"""
		Allow to recover all the informations of the padmet file.
		The section Data Base informations corresponds to the self.info
		The section Nodes corresponds to the data of each nodes in self.dicOfNode, sep ="\t"
		The section Relations corresponds to the data of each relations in self.dicOfRelationIn/Out, sep ="\t"
		@param padmet_file: the pathname of the padmet file to load.
		@return: _
		@rtype: None
		"""

	    initFromSbml(self, sbml_file, verbose = False):
		"""
		Initialize a padmetRef from sbml. Copy all species, convert id with sbmlPlugin
		stock name in COMMON NAME, stock original info in suppData. Copy all reactions,
		convert id with sbmlPlugin, stock name in common name, stock compart and stoichio data relative
		to reactants and products in the misc of consumes/produces relations
		@param sbml_file: pathname of the sbml file
		@param verbose: <bool> if True print supp info
		@type sbml_file: str
		"""

	    generateFile(self, output):
		"""
		Allow to create a padmet file to stock all the data.
		@param output: pathname of the padmet file to create
		@return: _
		@rtype: None
		"""

	    extract_data(self,output_directory, verbose = False):
		"""
		extracting data on rections and compounds in flate files.(used for samifier)
		"""

	#==============================================================================
	# For Nodes 
	#==============================================================================

	    _addNode(self,node):
		"""
		Allows to add a node, only if the id is not already used.
		@param node: the node to add
		@type node: Node
		@return: True if added, False if no.        
		@rtype: Bool
		"""

	#==============================================================================
	# For Relations:     
	#==============================================================================

	    _addRelation(self,relation):
		"""
		AddRelation() allows to add a relation if not already in allRelations.
		@param relation: the relation to add
		@type relation: Relation
		@return: true if relation was successfully added
		@rtype: bool
		"""

	#==============================================================================
	# manipulating de novo node:     
	#==============================================================================
	    
	    _basicNode(self, _type):
		"""
		For padmetRef, when creating a new node, a new id is creating. This id
		start with 'META_' for padmetRef (SPE_ for padmetSpe).
		This function generate a new id and an empty node with this id.
		@param _type: the type of the node to create
		@return: (newId,newNode)
		@rtype: tuple(str, Node)
		"""

	    getMaxLocalID(self):
		"""
		For padmetRef, when creating a new node, a new id is creating. This id
		start with 'META_' for padmetRef (SPE_ for padmetSpec) + an incremented int.
		This function extracts the max int (or max local id)
		@return: the max local id
		@rtype: int
		"""

	    createNode(self, _type, dicOfMisc, listOfRelation = None):
		"""
		Creation of new node to add in the network.
		use ._basicNode first then completes the node with more informations
		@param _type: type of node (gene, reaction...)
		@param dicOfMisc: dictionnary of miscellaneous data
		@param listOfRelation: list of list of data needed to create a relation. (id_in,type,id_out,misc)
		@type _type: str
		@type dicOfMisc: dict
		@type listOfRelation: = None, List.
		@return: (new_id,new_node)
		@rtype: tuple(str, Node)
		"""

padmetSpec.py
Description:
PadmetSpec is an object representing the metabolic network of a species(organism)
based on a reference database PadmetRef.

	class PadmetSpec:
	    """
	    PadmetSpec is an object representing the metabolic network of a species(organism)
	    based on a reference database PadmetRef.
	    contains <Policy>, <Node> and <Relation>
	    The policy defines the way Node and Relation are associated
	    A node is an Object that contains information about an element of the network 
	    (can be a pathway, reaction...).
	    A realtion defines how two nodes are connected. In a relation there is 
	    a node "in" and a node "out". (reactionX'in' consumes metaboliteX'out')
	    PadmetSpec contains 3 attributs: 
		dicOfNode: a dictionary of node: key=Node's unique id / value = <Node>
		dicOfRelationIn: a dictionnary of relation with: key= nodeIN id / value = list of <relation>
		dicOfRelationOut: a dictionnary of relation with: key= nodeOut id / value = list of <relation>
		policy: a <policy>
		info: a dictionnary of informations about the network, the database used...
		This dictionnary is always represented in the header of a padmet file
	    """
	    __init__(self, padmetSpec_file = None):
		"""
		if None, initializes an empty <PadmetSpec>
		@param padmetSpec_file: pathname of the padmet file
		@type padmetSpec_file: str
		@return: _
		@rtype: None
		"""

	#==============================================================================
	# Constructor / getter            
	#==============================================================================

	    setInfo(self,source):
		"""
		All the information printed in the header of a padmet stocked in a dict.
		{"metacyc":{version:XX,...},"ecocyc":{...}...}
		set Info from a dictionnary or copying from an other padmet
		@param source: may be a dict or an other padmet from where will be copied the info
		@tyme source: dict or Padmet
		"""

	    setPolicy(self,source):
		"""
		Set policy from a list or copying from an other padmet
		@param source: may be a list or an other padmet from where will be copied the policy
		@type source: list or Padmet
		"""

	    setDicOfNode(self,source):
		"""
		Set dicOfNode from a dict or copying from an other padmet
		@param source: may be a dict or an other padmet from where will be copied the dicOfNode
		@type source: dict or Padmet
		"""

	    setdicOfRelationIn(self,source):
		"""
		Set dicOfRelationIn from a dict or copying from an other padmet
		@param source: may be a dict or an other padmet from where will be copied the dicOfRelationIn
		@type source: dict or Padmet
		@rtype: None
		"""

	    setdicOfRelationOut(self,source):
		"""
		Set dicOfRelationOut from a dict or copying from an other padmet
		@param source: may be a dict or an other padmet from where will be copied the dicOfRelationIn
		@type source: dict or Padmet
		@rtype: None
		"""

	    getAllRelation(self):
		"""
		return a set of all relations
		@rtype: set
		"""

	    loadGraph(self, padmet_file):
		"""
		Allow to recover all the informations of the padmet file.
		The section Data Base informations corresponds to the self.info
		The section Nodes corresponds to the data of each nodes in self.dicOfNode, sep ="\t"
		The section Relations corresponds to the data of each relations in self.dicOfRelationIn/Out, sep ="\t"
		@param padmet_file: the pathname of the padmet file to load.
		@return: _
		@rtype: None
		"""

	    generateFile(self, output):
		"""
		Allow to create a padmet file to stock all the data.
		@param output: pathname of the padmet file to create
		@return: _
		@rtype: None
		"""

	    extract_pathway(self, node_id, padmetRef_file, output, sbml = None): 
		"""
		Allow to extract a pathway in a csv file. Need a padmetRef to check the total number
		of reactions in the pathway.
		Header = "Reactions (metacyc_id)", "Reactions (common_name)", "EC-Number",
		              "Formula (metacyc_id)", "Formula (common_name)", "Found in the network"
		@param node_id: id of the pathway
		@param padmetRef_ile: pathname of the padmet ref file
		@param output: pathname of the output to create
		@param sbml: if true, create a sbml file of this pathway
		@return: _
		@rtype: None
		"""

	    network_report(self, padmetRef_file, output_dir, verbose = False):
		"""
		Summurizes the network in a folder (output_dir) of 4 files.
		all_pathways.csv: report on the pathways of the network. PadmetRef is used to recover the total reactions of a pathways. (sep = "\t")
		line = dbRef_id, Common name, Number of reactions found, 
		    Total number of reaction, Ratio (Reaction found / Total)
		all_reactions.csv: report on the reactions of the network.  (sep = "\t")
		line = dbRef_id, Common name, formula (with id), 
		    formula (with common name), in pathways, associated genes, sources
		all_metabolites.csv: report on the metabolites of the network. (sep = "\t")
		line = dbRef_id, Common name, Produced (p), Consumed (c), Both (cp)
		all_genes.csv: report on the genes of the network. (sep= "\t")
		line = "id", "Common name", "linked reactions"
		@param padmetRef_file: pathname of the padmet of reference
		@param output_dir: pathname of the folder where to create the reports
		@param verbose: if true print info.
		@type padmetRef_file, output_dir: str
		@type verbose: bool
		@return: _
		@rtype: None
		"""

	#==============================================================================
	# For Nodes 
	#==============================================================================
		    
	    _addNode(self,node):
		"""
		Allows to add a node, only if the id is not already used.
		@param node: the node to add
		@type node: Node
		@return: True if added, False if no.        
		@rtype: Bool
		"""

	    _copyNodeExtend(self, padmet, node_id):
		"""
		Allows to copy a node from an other padmet with the first childrens only.
		Recursive function, call itself for the relations where the node is "in"
		NB: particular case: we dont want to recovere the relations "prot catalyses reaction"
		do nothing for the relations where the node is "out"
		@param padmet: Padmet from where to copy the node.
		@param node_id: the id of the node to copy.
		@type padmetRef: PadmetSpec/Ref
		@type node_id: str
		@return: _
		@rtype: None
		"""

	    copyNode(self, padmet, node_id):
		"""
		copyNode() allows to copy a node from an other padmetSpec or padmetRef. It copies all 
		the relations 'in' and 'out' and it calls the function 
		_copyNodeExtend() to recover the associated node.
		@param Padmet: PadmetSpec/Ref from where to copy the node
		@param node_id: the id of the node to copy
		@type padmetRef: PadmetSpec/Ref
		@type node_id: str
		@return: _
		@rtype: None
		"""

	    delNode(self, node_id):
		"""
		Allows to delete a node, the relations associated to the node, and for 
		some relations, delete the associated node. 
		For relations where the node to del is 'in': 
		    if rlt type in ['has_xref','has_name','has_suppData']: delNode out
		For relations where the node to del is 'out':
		    if rlt type in ['consumes','produces']
		@param node_id: id of node to delete
		@type node_id: str
		@return: True if node successfully deleted, False if node not in dicOfNode
		@rtype: Bool
		"""

	    updateNode(self, node_id, data, action, verbose = False):
		"""
		Allows to update miscellaneous data of a Node.
		@param node_id: the id of node to update
		@param data: tuple with data[0] refere to the miscellaneous data key 
		(ex: common_name, direction ...), data[1] is a list of value to add / update.
		data[1] can be None if the action is to pop the key
		@param action: if == "add": the list data[1] wil be added (ex: adding a common_name)
		if == "remove": if data[1] is not None, the list data[1] will be removed (ex: remove just one specifique common_name)
		if == "update":data[1] is the new value of the key data[0]
		ex: updateNode('RXN-5',('direction',['LEFT-TO-RIGHT']),update). The 
		reaction' direction will be change to left2right
		@param node_id: the id of the node to update
		@param data: tuple of data to update, data[0] is the key, data[1] is a value, list or None
		@param action: action in ['add','pop','remove','update']. Check description for more information
		@param verbose: print more info
		@type node_id, action: str
		@type data: list or None
		@type verbose: Bool
		@return: True if successfully updated, False if no
		@rtype: Bool
		"""

	#==============================================================================
	# For Relations:     
	#==============================================================================

	    _delRelation(self, relation):
		"""
		Delete a relation from dicOfRelationIn and out
		@param relation: the relation to delete
		@type relation: Relation
		@return: True if succesfully deleted
		@rtype: Bool
		"""

	    _addRelation(self,relation):
		"""
		AddRelation() allows to add a relation if not already in allRelations.
		@param relation: the relation to add
		@type relation: Relation
		@return: true if relation was successfully added
		@rtype: bool
		"""

	#==============================================================================
	# manipulating de novo node:     
	#==============================================================================
	    
	    _basicNode(self, _type):
		"""
		For padmetSpec, when creating a new node, a new id is creating. This id
		start with 'SPE_' for padmetSpec (META_ for padmetRef).
		This function generate a new id and an empty node with this id.
		@param _type: the type of the node to create
		@return: (newId,newNode)
		@rtype: tuple(str, Node)
		"""

	    getMaxLocalID(self):
		"""
		For padmetSpec, when creating a new node, a new id is creating. This id
		start with 'SPE_' for padmetSpec (META_ for padmetRef) + an incremented int.
		This function extracts the max int (or max local id)
		@return: the max local id
		@rtype: int
		"""

	    createNode(self, _type, dicOfMisc, listOfRelation = None):
		"""
		Creation of new node to add in the network.
		use ._basicNode first then completes the node with more informations
		@param _type: type of node (gene, reaction...)
		@param dicOfMisc: dictionnary of miscellaneous data
		@param listOfRelation: list of list of data needed to create a relation. (id_in,type,id_out,misc)
		@type _type: str
		@type dicOfMisc: dict
		@type listOfRelation: = None, List.
		@return: (new_id,new_node)
		@rtype: tuple(str, Node)
		"""

aspGenerator.py
Description:
This module contains functions to convert a padmet file to predicats for ASP

	asp_synt(pred, list_args):
	    """
	    create a predicat for asp

	    @example: asp_synt("direction",["R1","REVERSIBLE"]) => "direction('R1','reversible')."
	    @param pred: the predicat
	    @param list_args: list of atoms to put in the predicat
	    @type pred: str
	    @type list_args: list
	    @return: the predicat 'pred(''list_args[0]'',''list_args[1]'',...,''list_args[n]'').'
	    @rtype: str
	    """

	padmet_to_asp(padmet_file, output, verbose = False):
	    """
	    Convert PADMet to ASP following these predicats:
	    common_name({reaction_id or enzyme_id or pathway_id or compound_id} , common_name)
	    direction(reaction_id, reaction_direction). reaction_direction in[LEFT-TO-RIGHT,REVERSIBLE]
	    ec_number(reaction_id, ec(x,x,x)).
	    catalysed_by(reaction_id, enzyme_id).
	    uniprotID(enzyme_id, uniprot_id). #if has has_xref and db = "UNIPROT"
	    in_pathway(reaction_id, pathway_id).
	    reactant(reaction_id, compound_id, stoechio_value).
	    product(reaction_id, compound_id, stoechio_value).
	    is_a(compound_id, class_id).
	    is_a(pathway_id, pathway_id).

	    @param padmet_file: the path to padmet file to convert
	    @param output: the path to the output to create
	    @param verbose: print informations
	    @type padmet_file: str
	    @type output: str
	    @type verbose: bool
	    @return: _
	    @rtype: None
	    """

	padmetSpec_to_asp_for_deadend(padmetSpec_file, output, seeds_file, targets_file, verbose = False):
	    """
	    create .lp to run deadend_encoding.lp
	    predicats rules:
	    reaction('reaction_id').
	    reversible('reaction_id').
	    reactant('reactant_id', 'reaction_id').
	    product('product_id', 'reaction_id').
	    seed('seed_id').
	    target('target_id').
	    
	    @param padmetSpec_file: the path to padmet file to convert
	    @param output: the path to the output to create
	    @param seeds_file: the path to the file containing the seeds identifiers, 1/line
	    @param targets_file: the path to the file containing the targets identifiers, 1/line
	    @param output: the path to the output to create
	    @param verbose: print informations
	    @type padmetSpec_file, output, seeds_file, targets_file: str
	    @type verbose: bool
	    @return: _
	    @rtype: None
	    """    

sbmlGenerator.py
Description:
The module sbmlGenerator contains functions to generate sbml files from padmet and txt
usign the libsbml package

	check(value, message):
	    """If 'value' is None, prints an error message constructed using
	    'message' and then exits with status code 1.  If 'value' is an integer,
	    it assumes it is a libSBML return status code.  If the code value is
	    LIBSBML_OPERATION_SUCCESS, returns without further action; if it is not,
	    prints an error message constructed using 'message' along with text from
	    libSBML explaining the meaning of the code, and exits with status code 1.
	    """

	padmet_to_sbml(padmet_file, output, obj_fct = None, sbml_lvl = 2, sbml_version = 1, verbose = False):
	    """
	    Convert padmet file to sbml file.
	    Specificity: 
	    - ids are encoded for sbml using functions sbmlPlugin.convert_to_coded_id
	    @param padmet_file: the pathname to the padmet file to convert
	    @param output: the pathname to the sbml file to create
	    @param obj_fct: the identifier of the objection function, the reaction to test in FBA
	    @param sbml_lvl: the sbml level
	    @param sbml_version: the sbml version
	    @param verbose: print informations
	    @type padmet_file, output, verbose: str
	    @type sbml_lvl, sbml_version: int
	    @return: check return of writeSBMLToFile
	    @rtype: int
	    """

	#################################

	reactions_to_SBML(reactions_file, output, padmetRef_file, verbose = False):
	    """
	    convert a list of reactions to sbml format based on a given padmet of reference.
	    - ids are encoded for sbml using functions sbmlPlugin.convert_to_coded_id
	    @param reactions_file:the pathname to the file containing the reactions ids, 1/line
	    @param padmetRef_file: the pathname to the file padmet of reference
	    @param output: the pathname to the sbml file to create
	    @param sbml_lvl: the sbml level
	    @param sbml_version: the sbml version
	    @param verbose: print informations
	    @type reactions_file, output, padmetRef_file, verbose: str
	    @type sbml_lvl, sbml_version: int
	    @return: check return of writeSBMLToFile
	    @rtype: int
	    """

	compounds_to_sbml(compounds_file, output, padmetRef_file = None, padmetSpec_file = None, compart_name = None, sbml_lvl = 2, sbml_version = 1, verbose = False):
	    """
	    convert a list of compounds to sbml format
	    if compart_name is not None, then the compounds id will by: M_originalID_compart_name
	    if verbose and specified padmetRef and/or padmetSpec: will check if compounds are in one of the padmet files
	    Ids are encoded for sbml using functions sbmlPlugin.convert_to_coded_id
	    @param compounds_file:the pathname to the file containing the compounds ids, 1/line
	    @param output: the pathname to the sbml file to create
	    @param padmetRef_file: the pathname to the file padmet of reference
	    @param padmetRef_file: the pathname to the file padmet of a species
	    @param compart_name: the default compart to concatenate
	    @param sbml_version: the sbml version
	    @param verbose: print informations
	    @type compounds_file, output, padmetRef_file, padmetSpec_file, verbose: str
	    @type sbml_lvl, sbml_version: int
	    @return: check return of writeSBMLToFile
	    @rtype: int
	    """

sbmlPlugin.py
Description:
This module contains some functions used for sbml file in addition to libsbml
"""

	parseNotes(element):
	    """
	    From an SBML element (ex: species or reaction) will return all the section
	    note in a dictionnary.
	    ex:
	    <notes>
		<html:body>
		    <html:p>BIOCYC: |Alkylphosphonates|</html:p>
		    <html:p>CHEBI: 60983</html:p>
		</html:body>
	     </notes>
	    output: {'BIOCYC': ['Alkylphosphonates'],'CHEBI':['60983']}
	    value is a list in case diff lines for the same type of info

	    @param element: an element from libsbml
	    @type element: libsbml.element
	    @return: the dictionnary of note
	    @rtype: dict
	    """

	extractFormula(elementR):
	    """
	    From an SBML reaction_element will return the formula in a string
	    ex: '1.0 FRUCTOSELYSINE_p => 1.0 FRUCTOSELYSINE_c'
	    @param elementR: a reaction from libsbml.element
	    @type eleemntR: lisbsml.element
	    @return: the formule
	    @rtype: str
	    """

	parseGeneAssoc(GeneAssocStr):
	    """
	    Given a grammar of 'and', 'or' and '(' ')'. Extracts genes ids to a list.
	    (geneX and geneY) or geneW' => [geneX,geneY,geneW]
	    @param GeneAssocStr: the string containing genes ids
	    @type GeneAssocStr: str
	    @return: the list of unique ids
	    @rtype: list
	    """

	convert_to_coded_id(uncoded, _type = None, compart = None):
	    """
	    convert an id to sbml valid format. First add type of id "R" for reaction
	    "M" for compound at the start and the compart at the end.
	    _type+"_"+uncoded+"_"+compart
	    then remplace not allowed char by interger ordinal
	    @param uncoded: the original id to code
	    @param _type: the type of the id (ex: 'R' or 'M')
	    @param _compart: the compartiment of the id (ex: 'c' or 'e')
	    @type uncoded, _type, _compart: str
	    @return: the coded id
	    @rtype: str
	    """

	ascii_replace(match):
	    """
	    recover banned char from the integer ordinal in the reg.match
	    """

	convert_from_coded_id(coded):
	    """
	    convert an id from sbml format to the original id. try to extract the type of
	    the id and the compart using strong regular expression
	    @param coded: the encoded id
	    @type coded: str
	    @return: (the uncoded id, type=None, compart=None)
	    @rtype: tuple
	    """

	decode_bigg(identifier):
	    """Clean BiGG dirty identifiers from SBML
	    #TODO obsolete, to delete ?
	    ``identifier.lstrip('M_').rstrip('_e').rstrip('_b').rstrip('_c').replace('DASH', '')``
		- Remove '__DASH__' pattern
		- Remove 'M_' or 'R_' prefix
		- Remove '_x' suffix of compartment info


	    .. warning:: We assume that any compartment is composed of:
		- 1 character ONLY
		- the unique character IS NOT a digit

	    :param arg1: encoded id
	    :type arg1: <str>
	    :return: Return (decoded id,compart) None in case of failure (bad prefix)
	    :rtype: <str> or None
	    """

wikiGenerator.py
Description:
Contains all necessary function to generate wikiPages from a padmet file and update 
a wiki online. Require WikiManager module (with wikiMate,Vendor)
"""
	create_all_wikiPages(padmetRef_file, padmetSpec_file, output_dir, verbose = False):
	    """
	    Main function to generete wikiPages for a padmet. The padmetRef is used to add extra
	    information from the full database (ex: the numbers of total reactions in a pathway)
	    Steps:
	    0/ In output_dir, create 4 folder: metabolites, reactions, genes, pathways, navigation.
	    1/ Get all reactions, metabolites in reactions, pathways and genes
	    2/ for each element, create a file from the specific template in wikiCode

	    @param padmetRef_file: the pathname to the file padmet of reference
	    @param padmetSpec_file: the pathname to the file padmet to convert to wiki
	    @param output_dir: the pathname to folder where to store
	    @param verbose: print informations
	    @type padmetRef_file, padmetSpec_file, output_dir, verbose: str
	    @return: _
	    @rtype: None
	    """

	createDirectory(dirPath, verbose = False):
	    """
	    create the folders genes, reactions, metabolites, pathways in the folder dirPath/
	    if already exist, it will replace old folders (and delete old files)
	    """

	mp_createWikiPageGene(gene_id):
	    """
	    multiProcessing version of the function.
	    @param gene_id: the id of the gene to create a wiki page
	    @type gene_id: str
	    @return: _
	    @rtype: None
	    """

	createWikiPageGene(padmetSpec, gene_template, gene_id):
	    """
	    create a file with all the wikicode to create the page of the given Gene
	    @param padmetSpec: the Padmet instance of the network
	    @param gene_template: the template gene page
	    @param gene_id: gene id
	    @type padmetSpec: PadmetSpec
	    @type gene_template: list
	    @type gene_id: str
	    @return: pageInArray corresponding to the wikiPage
	    @rtype: list
	    """

	mp_createWikiPageReaction(reaction_id):
	    """
	    multiProcessing version of the function.
	    @param reactop,_id: the id of the reaction to create a wiki page
	    @type reaction_id: str
	    @return: _
	    @rtype: None
	    """

	createWikiPageReaction(padmetRef, padmetSpec, reaction_template, reaction_id):
	    """
	    create a file with all the wikicode to create the page of the given Reaction
	    @param padmetSpec: the Padmet instance of the network
	    @param reaction_template: the template reaction page
	    @param reactop,_id: reaction id
	    @type padmetSpec: PadmetSpec
	    @type reaction_template: list
	    @type reaction_id: str
	    @return: pageInArray corresponding to the wikiPage
	    @rtype: list
	    """

	mp_createWikiPagePathway(pathway_id):
	    """
	    multiProcessing version of the function.
	    @param pathway_id: the id of the pathway to create a wiki page
	    @type pathway_id: str
	    @return: _
	    @rtype: None
	    """

	createWikiPagePathway(padmetRef, padmetSpec, pathway_template, pathway_id):
	    """
	    create a file with all the wikicode to create the page of the given Reaction
	    @param padmetSpec: the Padmet instance of the network
	    @param pathway_template: the template pathway page
	    @param pathway_id: pathway id
	    @type padmetSpec: PadmetSpec
	    @type pathway_template: list
	    @type pathway_id: str
	    @return: pageInArray corresponding to the wikiPage
	    @rtype: list
	    """

	mp_createWikiPageMetabolite(metabolite_id):
	    """
	    multiProcessing version of the function.
	    @param metabolite_id: the id of the metabolite to create a wiki page
	    @type metabolite_id: str
	    @return: _
	    @rtype: None
	    """

	createWikiPageMetabolite(padmetSpec, metabolite_template, metabolite_id):
	    """
	    create a file with all the wikicode to create the page of the given metabolite
	    @param padmetSpec: the Padmet instance of the network
	    @param metabolite_template: the template metabolite page
	    @param metabolite_id: metabolite id
	    @type padmetSpec: PadmetSpec
	    @type metabolite_template: list
	    @type metabolite_id: str
	    @return: pageInArray corresponding to the wikiPage
	    @rtype: list
	    """

	assoc_correspondance(type_of_assoc):
	    """
	    The association gene-reaction can be convert to something more meaningful than a
	    simple tag. the dictionnary dictOfAssoc make the link for some of the associations.
	    @param type_of_assoc: the evidence allowing to link a gene to a reaction
	    @type type_of_assoc: str
	    @return: the meaningful correspondence
	    @rtype: str
	    """

	xrefLink(xrefNode):

	createDefaultPage():
	    """
	    Default pages are the pages used in a wiki to navigate: the category, the sidebar, the mainpage.
	    Sidebar: in the sidebar allows to navigate between categories of nodes and origins of reactions.
	    The origin of a reaction is recovered from node.misc['source']. if no source from the suppData
	    associated to this reaction suppdata_node.misc['origin_file]
	    """

	createWikiFile(pageInArray,fileName):
