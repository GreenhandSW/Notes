# 1. Union-Find

## Dynamic Connectivity

Given a set of N objects.

- Union command(`union(p, q)`): connect 2 objects.
- Find/connected query(`connected(p,q)`):  is there a path connecting the 2 objects?

assume "is connected" is an equivalence relation（等价关系）:

- Reflexive（自反性）: $p$ is connected to $p$.
- Symmetric（对称性）: if $p$ is connected to $q$, then $q$ is connected to $p$.
- Transitive（传递性）: if $p$ is connected to $q$ and $q$ is connected to $r$, then $p$ is connected to $r$.

**Connected components（连通分量）**: Maximal set of objects that are mutually connected.

our algorithms maintaining connected  components and using this to efficiently answer the query they are presented with.

### Implementing the operations

**Find query**: Check if 2 objects are in the same component.

**Union command**: Replace components containing 2 objects with their union.

