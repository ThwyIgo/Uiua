# Args: vertexCount
NewG ← |1 {⍥[]}
# Args: value vertexCount
NewGw ← |2 [⍥|]

# Args: origin graph
Adj ← |2 ⊔⊡

# Args: origin destination graph
AddE ← (|3
  ⊃⊙⋅∘⋅∘ # Reorder stack
  ⍜⊡⍜⊔⊂
)

# Args: origin destination graph
IsAdj ← |3 ∊⊃⋅∘(⊔⊡⊙⋅∘)

# Pop a value from a stack array
# Returns: value stack
PopS ← |1.2 ⊃'⊡0'↘1

# Topological order with DFS. It doesn't detect if the graph has cycles.
# Args: graph
Topo ← (|1
  [0]⊙[] # Setup stack (dfsStack graph visitedVertices). Always starts from vertex 0
  !(|3
    !(|3.3
      # Add unvisited vertices to dfsStack
      ⊙(⊂ ▽¬∊ ⊃⊙⋅⋅∘⊙⊙⊙∘ Adj).∶⊙PopS ,
      # Append current vertex to end of visitedVertices
      ⊃(⋅⊙∘)(⊂∶ ⊙⋅⋅∘)
      # If dfsStack isn't empty, recur
      ↬ ≠0⧻.
      # Bring appended vertex to front of visitedVertices
      ⊙⊙'↻¯1
    )
    ; # Drop dfsStack

    # Create array of unvisited vertices
    # First item of ⊕ are visited vertices and the second are unvisited ones. Drop the first
    ♭≡⊔↘1 ⊕□¬∊ ⊃⊙⋅∘⊙⊙∘ ⇡⧻.
    # If there are unvisited vertices, call Topo again with an unvisited vertex
    ?(∘;;)(|3 ↬2 [⊡0]) =0⧻.
  )
)

g ← {[3][0][][2]}
Topo g
