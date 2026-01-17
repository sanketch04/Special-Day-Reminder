<form action="${pageContext.request.contextPath}/admin/festival/upload"
      method="post" enctype="multipart/form-data">


    <select name="month" required>
        <option value="january">January</option>
        <option value="feb">February</option>
        <option value="march">March</option>
        <!-- all months -->
    </select>

    <input type="file" name="images" multiple required>

    <button type="submit">Upload</button>
</form>
