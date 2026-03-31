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
        [9 (string/format "[ HP.value \"%s\"" value)]
        [9 (string/format ", HP.selected (\"%s\" == selected)]" value)]
        [9 (string/format "[ HH.text \"%s\"]" text)]]
      @[[8 ", HH.option"]
        [9 (string/format " [ HP.value \"%s\"" value)]
        [9 (string/format " , HP.selected (\"%s\" == selected)]" value)]
        [9 (string/format " [ HH.text \"%s\"]" text)]])))

(def no-select [{:v "-" :t "-" :f true}])

(defn with-no-select [p]
  (let [skip (get p :skip-no-sel false)
        opts (p :options)]
    (if skip
      opts
      (array/concat @[] no-select opts))))


(defn mk-content [p]
  (let  [evt (p :evt)    
         class (p :class)
         disabled (if (p :disabled) "true" "false")
         opts1 (with-no-select p)]
    (let [opts (c/flatten (map mk-option opts1))]
      (let [main-array @[[5 "let"]
                         [6 "opts = "]
                         [7 "["]
                         [7 "]"]
                         [5 "in"]
                         [5 (string/format "HH.select")]
                         [6 (string/format "[ HP.classes [ ClassName \"%s\" ]" class)]
                         [6 (string/format ", HE.onValueChange %s" evt)]
                         [6 (string/format ", HP.disabled %s ]" disabled)]
                         [6 (string/format "%s" "opts")]]]
        (array/insert main-array 3 ;opts)))))


(defn make [act p]
  (let [sign (mk-sign (p :name) act)
        cnt (mk-content p)
        wp (w/mk-wrapper-prm (p :title) :lc (p :lc) :sc (p :sc))] 
    (array/join sign (w/wrapper wp cnt)))) 

(defn mk-sel-fn [ma] (fn [b] (make ma b)))

(defn run [selects action output-fn]
  (let [sel-fn (mk-sel-fn action)
        items (map sel-fn selects)]
    (map output-fn items)))

(defn params [name title evt options &keys {:lc label-class :c class :sc span-class :d disabled :skip-no-sel skip-no-sel}]
  (default disabled false)
  (default label-class "ps-label ps-mr-1")
  (default class "form-control ps-select")
  (default skip-no-sel false)
  { :name name 
    :title title 
    :evt evt 
    :options options
    :lc label-class 
    :class class
    :sc span-class
    :disabled disabled
    :skip-no-sel skip-no-sel})
   

(comment selects  
  @[{ :name "pageSelect" 
      :title "Page"
      :evt "PageChange"
      :options [{:v "calls" :t "Calls" :f true} {:v "puts" :t "Puts"}]
      :disabled "false"
      :lc label-class
      :skip-no-sel true} 
    { :name "tickerSelect" 
      :title "Ticker"
      :evt "TickerChange"
      :options tickers
      :lc label-class
      :disabled "false"}])
