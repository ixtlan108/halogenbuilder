(import /html/common :as c)
(import /html/wrapper :as w)


(def sp "")

(defn mk-sign [fn-name main-action]
    @[[1 sp] 
      [1 (string/format "%s :: forall w. String -> HTML w %s" fn-name main-action)]
      [1 (string/format "%s selected = " fn-name)]])

(defn mk-option [p]
  (let [value (p :v)
        text (p :t)
        is-first (p :f)]
    (if is-first
      @[[8 "HH.option"]
        [9 (string/format "[ HP.value \"%s\"]" value)]
        [9 (string/format ", HP.selected (\"%s\" == selected)]" value)]
        [9 (string/format "[ HH.text \"%s\"]" text)]]
      @[[8 ", HH.option"]
        [9 (string/format " [ HP.value \"%s\"]" value)]
        [9 (string/format " , HP.selected (\"%s\" == selected)]" value)]
        [9 (string/format " [ HH.text \"%s\"]" text)]])))

(defn mk-content [p]
  (let  [evt (p :evt)
         class (p :class)
         disabled (p :disabled)]
    (let [class1 (if class class "form-control ps-input")
          opts (c/flatten (map mk-option [{:v "a" :t "Ax" :f true} {:v "b" :t "Bux"}]))]
      (let [main-array @[[5 "let"]
                         [6 "opts = "]
                         [7 "["]
                         [7 "]"]
                         [5 "in"]
                         [5 (string/format "HH.select")]
                         [6 (string/format "[ HP.classes [ ClassName \"%s\" ]" class1)]
                         [6 (string/format ", HE.onValueChange %s" evt)]
                         [6 (string/format ", HP.disabled %s ]" disabled)]
                         [6 (string/format "%s" "opts")]]]
        (array/insert main-array 3 ;opts)))))


