
(defn mk-wrapper-prm [title &keys {:lc lc :sc sc}]
  (default lc "ps-label")
  (default sc "form-group")
  {:title title :label-class lc :span-class sc})


(defn wrapper [wrapper-prm content]
  (let [lc (wrapper-prm :label-class)
        sc (wrapper-prm :span-class)
        title (wrapper-prm :title)]
    (let [result @[[2 (string/format "HH.span [ HP.classes [ ClassName \"%s\" ]]" sc)]
                   [3 (string/format "[ HH.label [ HP.classes [ ClassName \"%s\" ]]" lc)]
                   [4 (string/format "[ HH.text \"%s\", " title)]]]
      (array/join result content @[[4 "]"] [3 "]"]]))))

#   (format nil "~2THH.span [ HP.classes \"~a\" ]~%~4T[ HH.label [ HP.classes [ \"~a\"] ]~%~6T[ HH.text \"~a\",~%~8T~a]" 
#          l-class s-class title content]))
