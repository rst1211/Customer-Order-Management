// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

let urlCustomer = "http://localhost:3000/get-ajax-customer/"

function applyAjaxResponse(data) {

    $("tbody.customer__infomations").empty()

    for (var i = 0; i < data.customerInfo.length; i++) {

        var id = data.customerInfo[i].id
        var name = data.customerInfo[i].name
        var phone = data.customerInfo[i].phone
        var address = data.customerInfo[i].address
        var email = data.customerInfo[i].email
    

        ajaxResponse = '<tr>\
            <th scope="row">'+(i+1)+'</th>\
            <td> <a href=/show-customer/'+id+'> '+name+' </a> </td>\
            <td>'+email+' </td>\
            <td>+91-'+phone+' </td>\
            <td class="address__of">'+address+' </td>\
            <td>0</td>\
            </tr>'


        $("tbody.customer__infomations").append(ajaxResponse)
    }
}

var ajaxReqButtons = document.getElementsByClassName("ajax-request");
for (var i = 0; i < ajaxReqButtons.length; i++) {

    ajaxReqButtons[i].addEventListener('click', function () {

        var dataOrdering = this.getAttribute("data-ordering")
        
        fetch(urlCustomer, {
            method: 'POST',
            headers: {
                "Content-Type": "application/json",
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            body: JSON.stringify({
                'dataOrdering': dataOrdering,
            })
        })
        
        .then((response) => {
            return response.json()
        }).then((data) => {


            applyAjaxResponse(data)

        })

    })
}





$("input.searchCustName").keyup(()=>{
    
    
    var searchValue = $("input.searchCustName").val()


    fetch(urlCustomer, {
        method: 'POST',
        headers: {
            "Content-Type": "application/json",
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        },
        body: JSON.stringify({
            'searchValue': searchValue,
        })
    })
    
    .then((response) => {
        return response.json()
    }).then((data) => {

        applyAjaxResponse(data)

    })


})


