<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
<title>Insert title here</title>
</head>
	<body>
	������ ���� ���Ű� �Ǿ����ϴ�.
	<table border=1>
		<tr>
			<td>��ǰ��ȣ</td>
			<td>${purchase.purchaseProd.prodNo}</td>
			<td></td>
		</tr>
		<tr>
			<td>�����ھ��̵�</td>
			<td>${purchase.buyer.userId}</td>
			<td></td>
		</tr>
		<tr>
			<td>���Ź��</td>
			<td>
			${purchase.paymentOption == "0" ? "���ݱ���" : "�ſ�ī��"} 
			</td>
			<td></td>
		</tr>
		<tr>
			<td>�������̸�</td>
			<td>${purchase.buyer.userName}</td>
			<td></td>
		</tr>
		<tr>
			<td>�����ڿ���ó</td>
			<td>${purchase.buyer.phone}</td>
			<td></td>
		</tr>
		<tr>
			<td>�������ּ�</td>
			<td>${purchase.buyer.addr}</td>
			<td></td>
		</tr>
			<tr>
			<td>���ſ�û����</td>
			<td>${purchase.dlvyRequest}</td>
			<td></td>
		</tr>
		<tr>
			<td>����������</td>
			<td>${purchase.dlvyDate}</td>
			<td></td>
		</tr>
	</table>
	</form>	
	</body>
</html>