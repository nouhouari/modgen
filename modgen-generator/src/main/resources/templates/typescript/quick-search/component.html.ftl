<form ng-submit="$ctrl.search()">
 <div class="input-group">
  <span class="input-group-btn form-search white-bg">
    <button type="submit">
      <i class="fa fa-search"></i>
    </button>
  </span>
  <input class="inputsearch" type="text" placeholder="Quick Search" ng-model="$ctrl.quickSearch" />
 </div>
</form>
