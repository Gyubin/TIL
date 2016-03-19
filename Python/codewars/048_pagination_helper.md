# #48 PaginationHelper

pagination 클래스다. paging할 collection과 한 페이지에 들어갈 개체 수를 지정해서 instance를 생성한다. 전체 아이템 수, 페이지 수, 특정 페이지의 아이템 수, 특정 아이템의 페이지 수를 리턴하는 함수들을 만들면 된다. 다른 답과 내 답이 동일해서 다른 답 코드는 적지 않았다.

## 1. 내 코드

```py
class PaginationHelper:

  # The constructor takes in an array of items and a integer indicating
  # how many items fit within a single page
  def __init__(self, collection, items_per_page):
    self.collection = collection
    self.items_per_page = items_per_page
  
  # returns the number of items within the entire collection
  def item_count(self):
    return len(self.collection)
      
  # returns the number of pages
  def page_count(self):
    result = self.item_count() / self.items_per_page
    if (self.item_count() % self.items_per_page) == 0: return result
    else: return result + 1
    
  # returns the number of items on the current page. page_index is zero based
  # this method should return -1 for page_index values that are out of range
  def page_item_count(self, page_index):
    if page_index >= self.page_count(): return -1
    elif page_index == self.page_count() - 1: return self.item_count() % self.items_per_page
    else: return self.items_per_page
  
  # determines what page an item is on. Zero based indexes.
  # this method should return -1 for item_index values that are out of range
  def page_index(self, item_index):
    if item_index < 0 or item_index >= self.item_count(): return -1
    else: return item_index // self.items_per_page
```
