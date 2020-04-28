package net.softsociety.zawa.dao;

/**
 * 타임라인 페이징 처리
 */
public class ScrollPageNavigator {
	private int countPerPage; // 페이지 당 글 목록 수
	private int currentPage; // 현재 페이지 (최근 글이 1부터 시작)
	private int totalRecordsCount; // 전체 글 수
	private int totalPageCount; // 전체 페이지 수
	private int startRecord; // 전체 레코드 중 현재 페이지 첫 글의 위치 (0부터 시작)

	public ScrollPageNavigator(int countPerPage, int currentPage, int totalRecordsCount) {
		this.countPerPage = countPerPage;
		this.totalRecordsCount = totalRecordsCount;

		// 전체 페이지 수
		totalPageCount = (totalRecordsCount + countPerPage - 1) / countPerPage;

		// 전달된 현재 페이지가 1보다 작으면 현재페이지를 1페이지로 지정
		if (currentPage < 1)
			currentPage = 1;
		// 전달된 현재 페이지가 마지막 페이지보다 크면 현재페이지를 마지막 페이지로 지정
		if (currentPage > totalPageCount)
			currentPage = totalPageCount;

		this.currentPage = currentPage;

		// 전체 레코드 중 현재 페이지 첫 글의 위치
		startRecord = (currentPage - 1) * countPerPage;
	}

	public int getCountPerPage() {
		return countPerPage;
	}

	public void setCountPerPage(int countPerPage) {
		this.countPerPage = countPerPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalRecordsCount() {
		return totalRecordsCount;
	}

	public void setTotalRecordsCount(int totalRecordsCount) {
		this.totalRecordsCount = totalRecordsCount;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public int getStartRecord() {
		return startRecord;
	}

	public void setStartRecord(int startRecord) {
		this.startRecord = startRecord;
	}

	@Override
	public String toString() {
		return "TimelinePageNavigator [countPerPage=" + countPerPage + ", currentPage=" + currentPage
				+ ", totalRecordsCount=" + totalRecordsCount + ", totalPageCount=" + totalPageCount + ", startRecord="
				+ startRecord + "]";
	}
}
