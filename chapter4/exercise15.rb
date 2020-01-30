# Exercise 15

def multiplySparseMatrices(arr2)
  result = ArrayRow.new
  new_array2 = ArrayRow.new
  arr2_row=arr2.sentinel.next_row
  while(arr2_row!=nil)
    r=arr2_row.row_number
    sentinel=arr2_row.row_sentinel
    while(sentinel.next_entry!=nil)
      new_array2.setValue(sentinel.next_entry.column_number,r,sentinel.next_entry.value)
      sentinel=sentinel.next_entry
    end
    arr2_row=arr2_row.next_row
  end

  arr1_row=@sentinel.next_row
  while(arr1_row!=nil)
    arr2_row=new_array2.sentinel.next_row # first column
    while(arr2_row!=nil)
      total=0
      arr1_cell=arr1_row.row_sentinel.next_entry
      arr2_cell=arr2_row.row_sentinel.next_entry
      while(arr1_cell!=nil&&arr2_cell!=nil)
        if(arr1_cell.column_number==arr2_cell.column_number)
          total+=arr1_cell.value*arr2_cell.value
          arr1_cell=arr1_cell.next_entry
          arr2_cell=arr2_cell.next_entry
        elsif(arr1_cell.column_number<arr2_cell.column_number)
          arr1_cell=arr1_cell.next_entry
        else
          arr2_cell=arr2_cell.next_entry
        end
      end
      result.setValue(arr1_row.row_number,arr2_row.row_number,total)
      arr2_row=arr2_row.next_row # next column
    end
    arr1_row=arr1_row.next_row
  end
  return result
end
