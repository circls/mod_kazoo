<table id="rs_monthly_fees_lists_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th class="td-center">{_ Date _}</th>
            <th class="td-center">{_ Description _}</th>
            <th class="td-center">{_ Sum _}</th>
            {% if (m.kazoo.kz_current_context_superadmin or m.kazoo.kz_current_context_reseller_status) %}
              <th class="td-center"></th>
            {% endif %}
        </tr>
    </thead>
    <tbody>
            {% for transaction in m.kazoo[{kz_list_transactions account_id=account_id payments_month_chosen=payments_month_chosen type="debit"}] %}
                <tr id={{ transaction["id"] }} {% if transaction["subscription_id"] %}style="cursor: pointer;"{% endif %}>
                    <td class="td-center">
                      {{ transaction["created"]|inno_timestamp_to_date }}
                      {{ transaction["created"]|inno_timestamp_to_date:"show_tz_name" }}
                    </td>
                    <td class="td-center">
                      {% if transaction["description"] %}
                        {{ transaction["description"] }}
                      {% else %}
                        {{ transaction["reason"] }}
                      {% endif %}
                    </td>
                    <td class="td-center">
                      {{ m.config.mod_kazoo.local_currency_sign.value }}{{ transaction["amount"]|format_price:[".",""] }}
                    </td>
                    {% if (m.kazoo.kz_current_context_superadmin or m.kazoo.kz_current_context_reseller_status) %}
                      <td class="td-center">
                        <i id="info_{{ transaction["id"] }}" class="fa fa-info-circle zprimary pointer" title="Details"></i>
                      </td>
                      {% wire id="info_"++transaction["id"]
                              action={dialog_open title=_"Daily fee details" ++ " " ++ transaction["id"]
                                          template="_onbill_transaction_details.tpl"
                                          transaction_id=transaction["id"]
                                          account_id=account_id
                                          width="auto"
                              }
                      %}
                   {% endif %}
                </tr>
            {% endfor %}
    </tbody>
</table>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#rs_monthly_fees_lists_table').dataTable({
"pagingType": "simple",
"bFilter" : true,
"aaSorting": [[ 0, "desc" ]],
"aLengthMenu" : [[5, 15, -1], [5, 15, "All"]],
"iDisplayLength" : 5,
"oLanguage" : {
        "sInfoThousands" : " ",
        "sLengthMenu" : "_MENU_ {_ lines per page _}",
        "sSearch" : "{_ Filter _}:",
        "sZeroRecords" : "{_ Nothing found, sorry _}",
        "sInfo" : "{_ Showing _} _START_ {_ to _} _END_ {_ of _} _TOTAL_ {_ entries _}",
        "sInfoEmpty" : "{_ Showing 0 entries _}",
        "sInfoFiltered" : "({_ Filtered from _} _MAX_ {_ entries _})",
        "oPaginate" : {
                "sPrevious" : "{_ Back _}",
                "sNext" : "{_ Forward _}"
        }
},

});

{% endjavascript %}

