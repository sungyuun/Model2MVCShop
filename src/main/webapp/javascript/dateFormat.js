function formatDate(date) {
	  
	
	// 월, 일, 시간, 분, 초 추출
	const month = (date.getMonth() + 1).toString().padStart(2, '0');
	const day = date.getDate().toString().padStart(2, '0');
	const hours = date.getHours().toString().padStart(2, '0');
	const minutes = date.getMinutes().toString().padStart(2, '0');
	const seconds = date.getSeconds().toString().padStart(2, '0');
	const ampm = hours >= 12 ? '오후' : '오전';
	const formattedHours = (hours % 12 || 12).toString().padStart(2, '0');
	
	// 날짜와 시간을 "mm-dd tt-mm-ss" 형식으로 조합
	const formattedDate = `${month}-${day} ${formattedHours}:${minutes}:${seconds}`;


  return formattedDate;
}





