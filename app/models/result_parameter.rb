class ResultParameter
  def initialize(params={})
    #params.assert_valid_keys("sex", "max_age", "mini_age", "prefecture_code")
    # @user = user
    @sex = params[:sex] == "1" || params[:sex] == "2" ?
            params[:sex] :
            ["1", "2"]
    @elder_birthday = params[:mini_age] == nil || params[:mini_age] == "" ?
                      "#{Date.today}" :
                      "#{Date.today.prev_year(params[:mini_age].to_i)}"
    @older_birthday = params[:max_age] == nil || params[:max_age] == "" ?
                      "#{Date.today.prev_year(140)}" :
                      "#{Date.today.prev_year(params[:max_age].to_i)}"
    @prefecture_code = params[:prefecture_code] != nil ?
                        params[:prefecture_code] :
                        [*(1..47)]
  end

  def define_params
    return {
        sex: @sex,
        elder_birthday: @elder_birthday,
        older_birthday: @older_birthday,
        prefecture_code: @prefecture_code
    }.with_indifferent_access.freeze
  end
end
