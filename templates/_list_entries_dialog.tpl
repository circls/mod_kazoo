
{% print m.kazoo[{kz_list_account_list_entries list_id=list_id}] %}
{% with m.kazoo[{kz_get_account_list list_id=list_id}] as list %}
{% wire id="form_add_list_entry" type="submit" postback="add_new_list_entry" delegate="mod_kazoo" %}
<form id="form_add_list_entry" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="list_entry_number" name="list_entry_number" placeholder="{_ Enter phone number here _}" value="{{ list[1]["name"] }}">
        </div>
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="list_entry_displayname" name="list_entry_displayname" placeholder="{_ Enter displayname here _}" value="{{ list[1]["description"] }}">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save list _}</button>
        </div>
      </div>
    </div>
{% if list_id %}
  <input type="hidden" name="list_id" value="{{ list[1]["id"] }}">
{% endif %}
</form>
{% print list[1] %}
{% endwith %}
