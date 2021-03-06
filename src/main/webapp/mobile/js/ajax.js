/**
 * 异步操作的js
 */
var global_path = "/nsff/";
var ajaxUtil = {
    /** 设置报到步骤 */
    setStep: function (num) {
        console.info("stepNumber: "+ num);
        $.ajax({
            url: global_path + 'student/student_setStep.action',
            type: "post",
            data: 'student.step=' + num
        });
    },


    /** 获取报到步骤 */
    getStep: function () {
        $.ajax({
            url: global_path + 'student/student_getStep.action',
            async: false,
            type: "post",
            dataType: 'json',
            success: function (data) {
                if (null != data && data != "") {
                    stepNumber = data.step;
                }
            },
            error: function (result) {
            }

        });
    },


    /** 提交 */
    submitAjax: function () {

        var queryString = $('#listFrom').serialize();
        $.ajax({
            url: this.url,
            cache: false,
            async: true,
            type: "post",
            dataType: 'text',
            data: queryString,
            success: function (t) {
                if (null != t && t != "") {
                    $("#initMore").hide();
                    $("#initMoreList").append(t);

                }
            },
            error: function (result) {
            }
        });

    },
    /** 加载更多 */
    more: function () {
        var nScrollHight = 0;
        var nScrollTop = 0;
        var nDivHight = $("#content").height();
        $("#content").scroll(function () {
            nScrollHight = $(this)[0].scrollHeight;
            nScrollTop = $(this)[0].scrollTop;
            if (nScrollTop + nDivHight >= nScrollHight) {
                if (parseInt($("#pageNo").val()) >= parseInt($("#totalPage").val())) {
                    return;
                }
                $("#initMore").show();
                $("#pageNo").val(parseInt($("#pageNo").val()) + 1);
                ajaxPage.submitAjax();
            }
        });
    }

};