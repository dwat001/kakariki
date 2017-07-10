package uk.co.kakariki.sorting;

public class MerdgeOne implements ArraySorter {

	private int[] toSort;
	private int[] scratch;
	
	@Override
	public int[] sort(int[] toSort) {
		if(toSort == null || toSort.length == 0){
			return new int[0];
		}
		if(toSort.length == 1){
			return toSort;			
		}
		scratch = new int[toSort.length];
		this.toSort = toSort;
		sortArea(0,toSort.length);
		this.toSort = null;
		this.scratch = null;
		return toSort;
	}
	
	private void sortArea(int low, int hi){
		if(hi<=(low+1))
				return;
		int mid = (low + hi) /2;
		sortArea(low,mid);
		sortArea(mid,hi);
		merdge(low,mid,hi);
	}
	
	private void merdge(int low, int mid, int high){
		assert(low<mid);
		assert(mid<high);
		// Copy the two sorted sub arrays to the scratch area.
		System.arraycopy(toSort, low, scratch, low, high -low);
		
		int firstIndex = low;
		int secondIndex = mid;
		int resultIndex = low;
		while(firstIndex < mid && secondIndex < high){
			if(scratch[firstIndex] <= scratch[secondIndex]){
				toSort[resultIndex++] = scratch[firstIndex++];
			}else{
				toSort[resultIndex++] = scratch[secondIndex++];
			}
		}
		
		assert(firstIndex == mid || secondIndex == high);
		if(firstIndex == mid && secondIndex == high){
			return;
		}
		if(firstIndex < mid){
			System.arraycopy(scratch, firstIndex, toSort, resultIndex, mid - firstIndex);
		}else{
			System.arraycopy(scratch, secondIndex, toSort, resultIndex, high-secondIndex);
		}
		
	}
	
	@Override
	public int getMaxRunLength() {
		return Integer.MAX_VALUE;
	}

	@Override
	public int getMaxTestLength() {
		return 1000000;
	}

}
