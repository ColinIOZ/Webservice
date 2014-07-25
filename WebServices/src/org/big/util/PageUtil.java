package org.big.util;

public class PageUtil{
	private int size;//分页每页显示的条目数  自定义
	private int num;//用户选择的页号  从前台用户传递而来
	private int rowCount;//该次查询信息的总数  从数据库查询而得
	
	private int pageCount;
	private int first = 1;
	private int last;
	private int prev;
	private int next;
	
	private int startRow;//查询起始的行号 即limit 后面第一个参数
	
	private int start;//导航栏开始位置
	private int end;//导航栏结束位置
	
	private int numCount = 10;//导航栏显示的页码数
	
	/**
	 * 计算出分页所有需要的数据
	 */
	public PageUtil(int size,String str_num,int webinfoCount){
		this.size = size;
		this.num = 1;
		if(str_num != null){
			this.num = Integer.parseInt(str_num);
		}
		this.rowCount = webinfoCount;
		
		this.pageCount = (int) Math.ceil((double)this.rowCount/this.size);
		
		this.last = this.pageCount;
		
		/*
		 * 只要页数超过范围  都显示第一页内容
		 */
//		if(this.num < 1 || this.num > this.last){
//			this.num = 1;
//		}
		
		/*
		 * 页数小于1 显示第一页  页数大于最后一页 显示最后一页
		 */
		this.num = Math.max(this.num, this.first);
		
		this.num = Math.min(this.last, this.num);
		
		this.next = this.num + 1;
		
		this.prev = this.num - 1;
		
		this.startRow = (this.num-1)*this.size;
		
		this.start = Math.max(this.first, this.num - this.numCount/2);
		
		this.end = Math.min(this.last, this.start + this.numCount);
		
		if(this.end - this.start < 10){
			this.start = Math.max(this.first, this.end - this.numCount);
		}
	}
	
	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getRowCount() {
		return rowCount;
	}

	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getFirst() {
		return first;
	}

	public void setFirst(int first) {
		this.first = first;
	}

	public int getLast() {
		return last;
	}

	public void setLast(int last) {
		this.last = last;
	}

	public int getPrev() {
		return prev;
	}

	public void setPrev(int prev) {
		this.prev = prev;
	}

	public int getNext() {
		return next;
	}

	public void setNext(int next) {
		this.next = next;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getNumCount() {
		return numCount;
	}

	public void setNumCount(int numCount) {
		this.numCount = numCount;
	}
}
