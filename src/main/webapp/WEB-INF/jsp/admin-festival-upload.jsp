<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Festival Upload | ASmitra Admin</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Custom CSS -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/admin-festival.css">
</head>

<body>

<div class="upload-card">

    <h3>Festival Assets Upload</h3>
    <p class="upload-sub">Upload festival images month-wise for reminders</p>

    <form action="${pageContext.request.contextPath}/admin/festival/upload"
          method="post" enctype="multipart/form-data">

        <!-- MONTH -->
        <div class="mb-4">
            <label class="form-label">Festival Month</label>
            <select name="month" class="form-select" required>
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
        </div>

        <!-- FILE -->
        <div class="file-wrap mb-2">
            <i class="bi bi-cloud-arrow-up"></i>
            <input type="file"
                   class="file-input w-100"
                   name="images"
                   multiple
                   required>
            <small>Select multiple images</small>
        </div>

        <div class="file-count" id="fileCount"></div>
        <div class="preview" id="preview"></div>

        <!-- SUBMIT -->
        <button type="submit" class="btn-upload" id="uploadBtn">
            <i class="bi bi-upload"></i>
            Upload Images
        </button>

    </form>
</div>

<script>
$(function () {

    /* File preview + count */
    $("input[type=file]").on("change", function () {
        const files = this.files;
        $("#preview").empty();

        if (files.length > 0) {
            $("#fileCount")
                .text(files.length + " file(s) selected")
                .fadeIn();
        } else {
            $("#fileCount").hide();
        }

        Array.from(files).slice(0,6).forEach(file => {
            if (file.type.startsWith("image")) {
                const reader = new FileReader();
                reader.onload = e => {
                    $("<img>").attr("src", e.target.result)
                              .appendTo("#preview");
                };
                reader.readAsDataURL(file);
            }
        });
    });

    /* Upload loading state */
    $("form").on("submit", function () {
        $("#uploadBtn")
            .addClass("loading")
            .html('<span class="spinner-border spinner-border-sm"></span> Uploading...');
    });

});
</script>

</body>
</html>
