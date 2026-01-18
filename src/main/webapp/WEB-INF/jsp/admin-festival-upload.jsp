<form action="${pageContext.request.contextPath}/admin/festival/upload"
      method="post" enctype="multipart/form-data">


    <select name="month" required>
        <option value="january">January</option>
        <option value="feb">February</option>
        <option value="march">March</option>
        <option value="april">April</option>
        <option value="may">May</option>
        <option value="june">June</option>
        <option value="julay">July</option>
        <option value="august">August</option>
        <option value="sept">September</option>
        <option value="october">October</option>
        <option value="november">November</option>
        <option value="december">December</option>
    </select>

    <input type="file" name="images" multiple required>

    <button type="submit">Upload</button>
</form>
