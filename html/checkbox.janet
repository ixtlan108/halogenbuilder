(import /html/common :as c)

(def sp "")

(defn mk-sign [fn-name main-action]
    @[[1 sp] 
      [1 (string/format "%s :: forall w. Boolean -> HTML w %s" fn-name main-action)]
      [1 (string/format "%s isChecked = " fn-name)]])



#ivCheck :: forall w. Boolean -> String -> String -> HTML w MainAction
#ivCheck isChecked title htmlId =
#HH.div [ HP.classes [ ClassName "form-check"]]
#    [ HH.input [HP.type_ InputCheckbox,HP.id htmlId, HP.classes [ ClassName "form-check-input" ], HP.checked isChecked, HE.onValueChange IvChecked]
#     , HH.label [ HP.classes [ClassName "form-check-label"], HP.for htmlId ] [ HH.text title])
    
(defn mk-content [p]
  (let [div-class (get p :cl-div"form-check form-switch")
        check-class (get p :cl-check "form-check-input") 
        label-class (get p :cl-lbl "form-check-label") 
        html-id (p :id)
        evt (p :evt)
        title (p :title)]
    @[[2 (string/format "HH.div [ HP.classes [ ClassName \"%s\" ]]" div-class)]
      [3 (string/format "[ HH.input [HP.type_ InputCheckbox, HP.id \"%s\", HP.classes [ ClassName \"%s\" ], HP.checked isChecked, HE.onValueChange %s ]"
            html-id check-class evt)]
      [3 (string/format ", HH.label [ HP.classes [ClassName \"%s\" ], HP.for \"%s\"] [ HH.text \"%s\"]" label-class html-id title)]
      [3 "]"]]))



(defn make [act p]
  (let [sign (mk-sign (p :name) act)
        cnt (mk-content p)]
    (array/join sign cnt))) 

(defn run [checks action output-fn]
  (let [mk-fn (partial make action)
        items (map mk-fn checks)]
    (map output-fn items)))

(defn main [&]
  (let [test { :id "htmlid" :evt "OnChecked" :title "Im a demo"}
        sign (mk-sign "ivCheck" "MainAction")
        result (mk-content test)]
    (map c/prn-result sign)
    (map c/prn-result result)))

