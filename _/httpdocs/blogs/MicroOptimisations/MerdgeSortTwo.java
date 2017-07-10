package uk.co.kakariki.sorting.two;

import uk.co.kakariki.sorting.ArraySorter;

public class MerdgeSortTwo implements ArraySorter {

	
	
	public int getMaxRunLength() {
		return Integer.MAX_VALUE;
	}

	public int getMaxTestLength() {
		return Integer.MAX_VALUE;
	}

	/**
	 * Peform an inplace merdge sort using a scratch array to reduce extra memory to O(n)
	 * Algorithim:
	 * 		split array in half, 
	 * 			sort left, 
	 * 			sort right,
	 * 			MerdgeResult 
	 */
	public int[] sort(int[] toSort) {
		if(toSort == null){
			return new int[0];
		}
		if(toSort.length ==0){
			return toSort;
		}
		int[] scratch = new int[toSort.length];
		doSort(toSort, scratch, 0, toSort.length);
		return toSort;
	}
	
	/**
	 * 
	 * @param toSort
	 * @param scratch
	 * @param start - inclusive
	 * @param end - excluded
	 */
	public void doSort(int[] toSort, int[] scratch, int start, int end){		
		assert(toSort != null && toSort.length > 0);
		int length = end - start;
		if(length <= 1){
			return; // a list of length one or zero is sorted. 
		}
		int leftEnd = start + (length / 2);
		//sort the Left half
		doSort(toSort, scratch, start, leftEnd);
		//sort the Right half
		doSort(toSort, scratch, leftEnd, end);
		
		merdge(toSort, scratch, start, leftEnd, end);	
	}

	private void merdge(int[] toSort, int[] scratch, int start, int leftEnd,
			int end) {
		// Copy entire region to scratch array
		System.arraycopy(toSort, start, scratch, start, end - start);
		// then move the lest element of left/right to the next index
		int destIndex = start;
		int leftIndex = start;
		int rightIndex = leftEnd;
		while(leftIndex < leftEnd && rightIndex < end){
			if(scratch[leftIndex] <= scratch[rightIndex]){
				toSort[destIndex++] = scratch[leftIndex++];
			}else{
				toSort[destIndex++] = scratch[rightIndex++];
			}
		}
		// we have exsahsted one or both of the left/right lists copy the rest of the other if required
		if(leftIndex < leftEnd){
			System.arraycopy(scratch, leftIndex, toSort, destIndex, leftEnd - leftIndex);
		}else if(rightIndex < end){
			System.arraycopy(scratch, rightIndex, toSort, destIndex, end - rightIndex);
		}else{
			assert(destIndex == end); // if we have exsahsted both left and right list ensure we are at the end
		}
		
		
	}

}
