function array_copy_fixed(dest, dest_index, src, src_index, length) {
	for (var i  = 0; (i < length && i + dest_index < array_length(dest)); i ++) {
		dest[dest_index + i] = src[src_index + i];
	}
}

function array_reverse_fixed(array, offset = 0, length = -1) {
	length = length == -1 ? array_length(array) : length;
	var temp;
	for (var i  = 0; i * 2 <= length; i ++) {
		temp = array[i + offset];
		array[i + offset] = array[offset + length - i - 1];
		array[offset + length - i - 1] = temp;
	}
}

function array_get_last_index(array, value, offset, length)
{
	for (var i = offset + length - 1; i >= offset; i ++) {
		if (array[i] == value && typeof(array[i]) == typeof(value)) {
			return i;
		}
	}
	return -1;
}

function List(ctorArg = undefined) constructor {
	static _defaultCapacity = 4;
	
    // private T[]
	_items = pointer_null;
    // private int
	_size = 0;
    // private int
	_version = 0;
    // private Object
	_syncRoot = pointer_null;
	
	static  _emptyArray = array_create(0);        
	
	// Constructs a List. The list is initially empty and has a capacity
	// of zero. Upon adding the first element to the list the capacity is
	// increased to 16, and then increased in multiples of two as required.
	_items = _emptyArray;
    
    // Constructs a List with a given initial capacity. The list is
    // initially empty, but will have room for the given number of elements
    // before any reallocations are required.
    // 
   if (is_real(ctorArg)) {
	   ctorArg = round(ctorArg);
        if (capacity < 0) show_error("", true);

        if (capacity == 0)
            _items = _emptyArray;
        else
            _items = array_create(capacity, undefined);
    }
    
    // Constructs a List, copying the contents of the given collection. The
    // size and capacity of the new list will both be equal to the size of the
    // given collection.
    // 
    if (is_array(ctorArg)) {
        var count = array_length(ctorArg);
        if (count == 0) {
            _items = _emptyArray;
        }
        else {
            _items = array_create(count, undefined);
			array_copy_fixed(_items, 0, ctorArg, 0, count);
            _size = count;
        }
    }
        
    // Gets and sets the capacity of this list.  The capacity is the size of
    // the internal array used to hold items.  When set, the internal 
    // array of the list is reallocated to the given capacity.
    // 
    // public int 
	Capacity = {
		this : other,
        Get : function () {
            return this._items.Length;
        },
        Set : function (value) {
            if (value < this._size) {
                show_error("", true);
            }
			
            if (value != array_length(this._items)) {
                if (value > 0) {
                   var newItems = array_create(value, undefined);
                    if (this._size > 0) {
						array_copy_fixed(newItems, 0, this._items, 0, this._size);
                    }
                    this._items = newItems;
                }
                else {
                    this._items = this._emptyArray;
                }
            }
        }
    };
            
    // Read-only property describing how many elements are in the List.
    //public int
	Count = {
		this : other,
        Get : function () {
            return this._size; 
        }
    }
    
    // Sets or Gets the element at the given index.
    // 
    //public T
	Get = function (index) {
        // Following trick can reduce the range check by one
        if ( index >= _size) {
			show_error("", true);
        }
        return _items[index]; 
    };

    Set = function (index, value) {
        if (index >= _size) {
			show_error("", true);
        }
        _items[index] = value;
        _version ++;
    };

    // Adds the given object to the end of this list. The size of the list is
    // increased by one. If required, the capacity of the list is doubled
    // before adding the new element.
    //
    //public void
	Add = function (listitem) {
        if (_size == array_length(_items)) {
			EnsureCapacity(_size + 1);
		}
        _items[_size ++] = listitem;
        _version ++;
    };

    // Adds the elements of the given collection to the end of this list. If
    // required, the capacity of the list is increased to twice the previous
    // capacity or the new size, whichever is larger.
    //
    //public void
	AddRange = function (collection) {
        InsertRange(_size, collection);
    }
	
    // Clears the contents of List.
    //public void 
	Clear = function () {
        if (_size > 0) {
           for (var i = 0; i < array_length(_items); i ++) {
			   _items[0] = undefined;
		   }
		   // Don't need to doc this but we clear the elements so that the gc can reclaim the references.
            _size = 0;
        }
        _version++;
    }
    
    // Contains returns true if the specified element is in the List.
    // It does a linear, O(n) search.  Equality is determined by calling
    // item.Equals().
    //
    //public bool
	Contains = function (listitem) {
        if (listitem == pointer_null) {
            for (var i = 0; i < _size; i ++)
                if (_items[i] == pointer_null)
                    return true;
            return false;
        }
		else if (listitem == undefined) {
            for (var i = 0; i < _size; i ++)
                if (_items[i] == undefined)
                    return true;
            return false;
        }
        else {
            for(var i = 0; i < _size; i ++) {
                if (_items[i] == listitem && typeof(_items[i]) == typeof(listitem)) return true;
            }
            return false;
        }
    }

    //public List<TOutput> 
	ConvertAll = function (converter) {
        if (!is_callable(converter)) {
            //ThrowHelper.ThrowArgumentNullException(ExceptionArgument.converter);
			show_error("", true);
        }
        // @



        list = new List(_size);
        for (var i = 0; i< _size; i ++) {
            list._items[i] = converter(_items[i]);
        }
        list._size = _size;
        return list;
    }

    // Copies this List into array, which must be of a 
    // compatible array type.  
    //
    // public void 
	CopyTo = function (index, array, arrayIndex = 0, count = -1) {
		array_copy_fixed(array, index, _items, arrayIndex, count == -1 ? _size : count);
    }

    // Ensures that the capacity of this list is at least the given minimum
    // value. If the currect capacity of the list is less than min, the
    // capacity is increased to twice the current capacity or to min,
    // whichever is larger.
    // private void 
	EnsureCapacity = function (min) {
		static MaxArrayLength = 1024;
        if (array_length(_items) < min) {
            var newCapacity = array_length( _items) == 0? _defaultCapacity : array_length(_items) * 2;
            // Allow the list to grow to maximum possible capacity (~2G elements) before encountering overflow.
            // Note that this check works even when _items.Length overflowed thanks to the (uint) cast
            if (newCapacity > MaxArrayLength) newCapacity = MaxArrayLength;
            if (newCapacity < min) newCapacity = min;
            Capacity.Set(newCapacity);
        }
    }
   
    //public bool 
	Exists = function (match) {
        return FindIndex(match) != -1;
    }

    //public T 
	Find = function (match) {
        if (!is_callable(match)) {
            // ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
			show_error("", true);
        }

        for (var i = 0; i < _size; i ++) {
            if (match(_items[i])) {
                return _items[i];
            }
        }
        return undefined;
    }
  
    // public List<T>
	FindAll = function (match) { 
        if (!is_callable(match)) {
            // ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
			show_error("", true);
        }

        var list = new List(0); 
        for (var i = 0 ; i < _size; i ++) {
            if (match(_items[i])) {
                list.Add(_items[i]);
            }
        }
        return list;
    }
	
    FindIndex = function (match, startIndex = 0, count = -1) {
		count = count == -1 ? _size : count;
        if (startIndex > _size) {
            //ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.startIndex, ExceptionResource.ArgumentOutOfRange_Index);                
			show_error("", true);
        }

        if (count < 0 || startIndex > _size - count) {
            //ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_Count);
			show_error("", true);
        }

        if (!is_callable(match)) {
            //ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
			show_error("", true);
        }

        var endIndex = startIndex + count;
        for (var i = startIndex; i < endIndex; i ++) {
            if (match(_items[i])) return i;
        }
        return -1;
    }
 
    //public T 
	FindLast = function(match) {
        if (!is_callable(match)) {
            //ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
			show_error("", true);
        }

        for (var i = _size - 1; i >= 0; i --) {
            if (match(_items[i])) {
                return _items[i];
            }
        }
        return undefined;
    }

    //public int 
	FindLastIndex = function (match, startIndex = 0, count = -1) {
		count = count == -1 ? _size : count;
        if (!is_callable(match)) {
            // ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
			show_error("", true);
        }

        if (_size == 0) {
            // Special case for 0 length List
            if (startIndex != -1) {
                // ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.startIndex, ExceptionResource.ArgumentOutOfRange_Index);
				show_error("", true);
            }
        }
        else {
            // Make sure we're not out of range            
            if (startIndex >= _size) {
                // ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.startIndex, ExceptionResource.ArgumentOutOfRange_Index);
				show_error("", true);
            }
        }
            
        // 2nd have of this also catches when startIndex == MAXINT, so MAXINT - 0 + 1 == -1, which is < 0.
        if (count < 0 || startIndex - count + 1 < 0) {
            //ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_Count);
			show_error("", true);
        }
                        
        var endIndex = startIndex - count;
        for (var i = startIndex; i > endIndex; i --) {
            if (match(_items[i])) {
                return i;
            }
        }
        return -1;
    }

    //public void 
	ForEach = function (action) {
        if (!is_callable(action)) {
            // ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
			show_error("", true);
        }

        var version = _version;

        for (var i = 0; i < _size; i ++) {
            if (version != _version) {
                break;
            }
            action(_items[i]);
        }

        if (version != _version)
            //ThrowHelper.ThrowInvalidOperationException(ExceptionResource.InvalidOperation_EnumFailedVersion);
			show_error("", true);
    }

    //public List<T> 
	GetRange = function (index, count) {
        if (index < 0) {
            // ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.index, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
			show_error("", true);
        }

        if (count < 0) {
            // ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
			show_error("", true);
        }

        if (_size - index < count) {
            // ThrowHelper.ThrowArgumentException(ExceptionResource.Argument_InvalidOffLen);                
			show_error("", true);
        }

        var list = new List(count);
        array_copy_fixed(list._items, 0, _items, index, count);            
        list._size = count;
        return list;
    }

    // Returns the index of the first occurrence of a given value in a range of
    // this list. The list is searched forwards, starting at index
    // index and upto count number of elements. The
    // elements of the list are compared to the given value using the
    // Object.Equals method.
    // 
    // This method uses the Array.IndexOf method to perform the
    // search.
    // 
    // public int
	IndexOf = function (listitem, index = 0, count = -1) {
		count = count == -1 ? _size : count;
        if (index > _size)
            //ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.index, ExceptionResource.ArgumentOutOfRange_Index);
			show_error("", true);

        if (count < 0 || index > _size - count)
			//ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_Count);
			show_error("", true);

        return array_get_index(_items, listitem, index, count);
    }
    
    // Inserts an element into this list at a given index. The size of the list
    // is increased by one. If required, the capacity of the list is doubled
    // before inserting the new element.
    // 
    //public void 
	Insert = function (index, listitem) {
        // Note that insertions at the end are legal.
        if (index > _size) {
            // ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.index, ExceptionResource.ArgumentOutOfRange_ListInsert);
			show_error("", true);
        }
        if (_size == _items.Length) EnsureCapacity(_size + 1);
        if (index < _size) {
            array_copy_fixed(_items, index + 1, _items, index,  _size - index);
        }
        _items[index] = listitem;
        _size ++;            
        _version ++;
    }
    
  
    // Inserts the elements of the given collection at a given index. If
    // required, the capacity of the list is increased to twice the previous
    // capacity or the new size, whichever is larger.  Ranges may be added
    // to the end of the list by setting index to the List's size.
    //
    // public void 
	InsertRange = function (index, collection) {
        if (!is_array(collection)) {
            //ThrowHelper.ThrowArgumentNullException(ExceptionArgument.collection);
			show_error("", true);
        }
            
        if (index > _size) {
            //ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.index, ExceptionResource.ArgumentOutOfRange_Index);
			show_error("", true);
        }

        var count = array_length(collection);
        if (count > 0) {
            EnsureCapacity(_size + count);
            if (index < _size) {
                array_copy_fixed(_items, index + count, _items, index, _size - index);
            }
                    
            // If we're inserting a List into itself, we want to be able to deal with that.
            if (self == collection) {
                // Copy first part of _items to insert location
                array_copy_fixed(_items, index, _items, 0, index);
                // Copy last part of _items back to inserted location
                array_copy_fixed(_items, index*2, _items, index+count, _size-index);
            }
            else {
                var itemsToInsert = array_create(count);
                array_copy_fixed(itemsToInsert, 0, collection, 0, count);
                array_copy_fixed(_items, index, itemsToInsert, 0, count);
            }
            _size += count;
        }
        _version ++;            
    }

    // Returns the index of the last occurrence of a given value in a range of
    // this list. The list is searched backwards, starting at index
    // index and upto count elements. The elements of
    // the list are compared to the given value using the Object.Equals
    // method.
    // 
    // This method uses the Array.LastIndexOf method to perform the
    // search.
    // 
    // public int 
	LastIndexOf = function (listitem, index = 0, count = -1) {
		count = count == -1 ? _size : count;
        if ((Count.Get() != 0) && (index < 0)) {
            //ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.index, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
			show_error("", true);
        }

        if ((Count.Get() !=0) && (count < 0)) {
            //ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
			show_error("", true);
        }

        if (_size == 0) {  // Special case for empty list
            return -1;
        }

        if (index >= _size) {
            //ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.index, ExceptionResource.ArgumentOutOfRange_BiggerThanCollection);
			show_error("", true);
        }

        if (count > index + 1) {
            //ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_BiggerThanCollection);
			show_error("", true);
        } 

        return array_get_last_index(_items, listitem, index, count);
    }
    
    // Removes the element at the given index. The size of the list is
    // decreased by one.
    // 
    //public bool 
	Remove = function (listitem) {
        var index = IndexOf(listitem);
        if (index >= 0) {
            RemoveAt(index);
            return true;
        }

        return false;
    }


    // This method removes all items which matches the predicate.
    // The complexity is O(n).   
    //public int 
	RemoveAll = function (match) {
        if (!is_callable(match)) {
            //ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
			show_error("", true);
        }
    
        var freeIndex = 0;   // the first free slot in items array

        // Find the first item which needs to be removed.
        while (freeIndex < _size && !match(_items[freeIndex])) freeIndex ++;            
        if (freeIndex >= _size) return 0;
            
        var current = freeIndex + 1;
        while (current < _size) {
            // Find the first item which needs to be kept.
            while (current < _size && match(_items[current])) current ++;            

            if (current < _size) {
                // copy item to the free slot.
                _items[freeIndex ++] = _items[current ++];
            }
        }                       
        
		for (var i = freeIndex; i < _size; i ++)
			_items[i] = undefined;
        var result = _size - freeIndex;
        _size = freeIndex;
        _version ++;
        return result;
    }

    // Removes the element at the given index. The size of the list is
    // decreased by one.
    // 
    // public void
	RemoveAt = function (index) {
        if (index >= _size) {
            //ThrowHelper.ThrowArgumentOutOfRangeException();
			show_error("", true);
        }
        _size --;
        if (index < _size) {
            array_copy_fixed(_items, index, _items, index + 1, _size - index);
        }
        _items[_size] = undefined;
        _version ++;
    }
    
    // Removes a range of elements from this list.
    // 
    // public void 
	RemoveRange = function (index, count) {
        if (index < 0) {
            // ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.index, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
			show_error("", true);
        }

        if (count < 0) {
            // ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
			show_error("", true);
        }
                
        if (_size - index < count)
            // ThrowHelper.ThrowArgumentException(ExceptionResource.Argument_InvalidOffLen);
			show_error("", true);
    
        if (count > 0) {
            var i = _size;
            _size -= count;
            if (index < _size) {
                array_copy_fixed(_items, index, _items, index + count, _size - index);
            }
			for (var i = _size; i < _size + count; i ++)
	            _items = undefined;
            _version ++;
        }
    }
	
    // Reverses the elements in a range of this list. Following a call to this
    // method, an element in the range given by index and count
    // which was previously located at index i will now be located at
    // index index + (index + count - i - 1).
    // 
    // This method uses the Array.Reverse method to reverse the
    // elements.
    // 
    // public void 
	Reverse = function (index, count) {
        if (index < 0) {
            // ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.index, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
			show_error("", true);
        }
                
        if (count < 0) {
            // ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
			show_error("", true);
        }

        if (_size - index < count)
            // ThrowHelper.ThrowArgumentException(ExceptionResource.Argument_InvalidOffLen);
			show_error("", true);
        array_reverse_fixed(_items, index, count);
        _version ++;
    }

    // Sorts the elements in a section of this list. The sort compares the
    // elements to each other using the given IComparer interface. If
    // comparer is null, the elements are compared to each other using
    // the IComparable interface, which in that case must be implemented by all
    // elements of the list.
    // 
    // This method uses the Array.Sort method to sort the elements.
    // 
    //public void 
	Sort = function (comparer) {
        array_sort(_items, comparer);
        _version++;
    }

    // ToArray returns a new Object array containing the contents of the List.
    // This requires copying the List, which is an O(n) operation.
    // public T[] 
	ToArray = function () {
        var array = array_create(_size, undefined);
        array_copy_fixed(array, 0, _items, 0, _size);
        return array;
    }
    
    // Sets the capacity of this list to the size of the list. This method can
    // be used to minimize a list's memory overhead once it is known that no
    // new elements will be added to the list. To completely clear a list and
    // release all memory referenced by the list, execute the following
    // statements:
    // 
    // list.Clear();
    // list.TrimExcess();
    // 
    // public void 
	TrimExcess = function () {
        var threshold = round((array_length(_items) * 0.9));             
        if (_size < threshold ) {
            Capacity.Set(_size);                
        }
    }    

    // public bool 
	TrueForAll = function (match) {
        if (!is_callable(match)) {
            //ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
			show_error("", true);
        }

        for (var i = 0; i < _size; i ++) {
            if (!match(_items[i])) {
                return false;
            }
        }
        return true;
    } 
}