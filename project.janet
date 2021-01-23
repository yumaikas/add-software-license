(declare-project 
    :name "spit-mit"
    # Note, I happen to use the MIT liscense, 
    # I'm certainly ok with other projects forking and customizing this 
    # for their preferred license templates
    :description "Spits out an MIT license template for use when creating GIT repos."
)

(declare-executable 
    :name "spit-mit"
    :entry "add-mit-license.janet"
)

