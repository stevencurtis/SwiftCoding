```swift
Collection View Cell Self-Sizing Checklist

Here is brief summary of the steps to enable collection view cell self-sizing:

Identify dynamic elements within collection view cell which should grow.
Setup auto layout constraints in a such way, that dynamic elements are pinned to all edges of the content view either directly or indirectly, ex. when wrapped in containers like UIView or UIStackView.
Enable auto layout for cell content view and pin it to the edges of the cell.
Add extra width constraint with less than or equal relation, which limits cell from growing horizontally beyond screen bounds.
Make sure that dynamic UI elements can grow vertically when content increases. Some examples are: make UILabel multi-line, disable scrolling for UITextView.
Set cell maximal width from collectionView(:cellForItemAt:).
Set collection view flow layout property estimatedItemSize to a non-zero value, typically to UICollectionViewFlowLayout.automaticSize.
```
