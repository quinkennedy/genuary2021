(ns day01.core
    (:require
      [thi.ng.math.core :as m]
      [thi.ng.geom.core :as g]
      [thi.ng.geom.circle :as c]
      [thi.ng.geom.sphere :as s]
      [thi.ng.geom.plane :as p]
      [thi.ng.geom.vector :as v :refer [vec3]]
      [thi.ng.geom.svg.core :as svg]
      [thi.ng.geom.svg.adapter :as adapt]
      [thi.ng.color.core :as col]
      [reagent.dom :as rdom]))

(defn svg-component [width body]
  [:div
    (->> body
      (adapt/all-as-svg)
      (adapt/inject-element-attribs adapt/key-attrib-injector)
        (svg/svg {:width width :height width}))])

(defn complex []
  (svg-component 300
    (svg/group
      {:stroke "red" :fill "none"}
      (g/intersect-shape
        (s/sphere [150 150 0] 20)
        (p/plane [0 0 0] [0 0 1])))))

(defn simple []
  (svg-component 300
    (svg/group
      {:stroke "blue" :fill "none"}
      (c/circle 150 150 20))))

(defn ^:export main []
  (rdom/render
    [complex]
    (js/document.getElementById "app")))

(enable-console-print!)

(println "This text is printed from src/day01/core.cljs. Go ahead and edit it and see reloading in action.")
(println
  (g/intersect-shape
    (c/circle 20)
    (c/circle 20 0 20)))
(println
      (g/intersect-shape
        (s/sphere [0 0 0] 20)
        (s/sphere [20,0,0] 20)))
(println
      (g/intersect-shape
        (p/plane-with-point (vec3 0 0 0) v/V3Z)
        (p/plane-with-point (vec3 0 0 0) v/V3Y)))
(cljs.pprint/pprint
  (let [sp (s/sphere [0 0 0] 20)]
    (closest-point
      )

      (g/intersect-shape
        (p/plane-with-point (vec3 0 0 0) v/V3Z)))
(println
        (s/sphere [0 0 0] 20))
(println
        (p/plane-with-point (vec3 0 0 0) v/V3Z))
(main)

;; define your app data so that it doesn't get over-written on reload

(defonce app-state (atom {:text "Hello world!"}))

(defn on-js-reload []
  ;; optionally touch your app-state to force rerendering depending on
  ;; your application
  ;; (swap! app-state update-in [:__figwheel_counter] inc)
)
