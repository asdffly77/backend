!function(e){var t={};function n(a){if(t[a])return t[a].exports;var r=t[a]={i:a,l:!1,exports:{}};return e[a].call(r.exports,r,r.exports,n),r.l=!0,r.exports}n.m=e,n.c=t,n.d=function(e,t,a){n.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:a})},n.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},n.t=function(e,t){if(1&t&&(e=n(e)),8&t)return e;if(4&t&&"object"==typeof e&&e&&e.__esModule)return e;var a=Object.create(null);if(n.r(a),Object.defineProperty(a,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var r in e)n.d(a,r,function(t){return e[t]}.bind(null,r));return a},n.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return n.d(t,"a",t),t},n.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},n.p="https://x-assets.coinvoice.cn/static/",n(n.s="6VO7")}({"2KCw":function(e,t){var n={isWebGLAvailable:function(){try{var e=document.createElement("canvas");return!(!window.WebGLRenderingContext||!e.getContext("webgl")&&!e.getContext("experimental-webgl"))}catch(e){return!1}},isWebGL2Available:function(){try{var e=document.createElement("canvas");return!(!window.WebGL2RenderingContext||!e.getContext("webgl2"))}catch(e){return!1}},getWebGLErrorMessage:function(){return this.getErrorMessage(1)},getWebGL2ErrorMessage:function(){return this.getErrorMessage(2)},getErrorMessage:function(e){var t={1:window.WebGLRenderingContext,2:window.WebGL2RenderingContext},n='Your $0 does not seem to support <a href="http://khronos.org/webgl/wiki/Getting_a_WebGL_Implementation" style="color:#000">$1</a>',a=document.createElement("div");return a.id="webglmessage",a.style.fontFamily="monospace",a.style.fontSize="13px",a.style.fontWeight="normal",a.style.textAlign="center",a.style.background="#fff",a.style.color="#000",a.style.padding="1.5em",a.style.width="400px",a.style.margin="5em auto 0",n=(n=t[e]?n.replace("$0","graphics card"):n.replace("$0","browser")).replace("$1",{1:"WebGL",2:"WebGL 2"}[e]),a.innerHTML=n,a}};window.WEBGL||(window.WEBGL=n)},"2ysp":function(e,t,n){"use strict";n.d(t,"a",(function(){return i}));n("2KCw");var a=window,r=a.WEBGL,o=a.THREE;function i(e,t){if(r.isWebGLAvailable()){var n=new o.WebGLRenderer({antialias:!0,alpha:!0}),a=new o.PerspectiveCamera(50,e.clientWidth/e.clientHeight,1,1e3);n.setSize(e.clientWidth,e.clientHeight),e.appendChild(n.domElement),window.addEventListener("resize",(function(){n.setSize(e.clientWidth,e.clientHeight),a.aspect=e.clientWidth/e.clientHeight,a.updateProjectionMatrix()}),!1);var i=new o.OrbitControls(a,n.domElement);i.enableDamping=!0,i.rotateSpeed=.05,i.dampingFactor=.1,i.enableZoom=!0,i.enablePan=!1,i.autoRotate=!0,i.autoRotateSpeed=.75;var c=new o.Scene;c.add(new o.HemisphereLight(16777215,526368,1.5)),(new o.STLLoader).load(t,(function(t){var r,l=e.getAttribute("data-color");r=null!=l?new o.Color(l):16733491;var d=new o.MeshPhongMaterial({color:r,specular:100,shininess:100}),s=new o.Mesh(t,d);c.add(s);var u=new o.Vector3;t.computeBoundingBox(),t.boundingBox.getCenter(u),s.geometry.applyMatrix((new o.Matrix4).makeTranslation(-u.x,-u.y,-u.z)),"x"===e.getAttribute("data-rotate")&&(s.rotation.x=-Math.PI/2);for(var g=Math.max(t.boundingBox.max.x,t.boundingBox.max.y,t.boundingBox.max.z),p=1;g*p>10;)p*=.1;s.scale.set(p,p,p),a.position.z=g*p*e.getAttribute("data-zdistance"),function e(){requestAnimationFrame(e),i.update(),n.render(c,a)}()}))}else e.appendChild(r.getWebGLErrorMessage())}t.b=function(e){for(var t=document.querySelectorAll(e),n=0;n<t.length;n+=1)i(t[n],t[n].getAttribute("data-src"))}},"6VO7":function(e,t,n){"use strict";n.r(t);var a=n("2ysp"),r=window.$,o=window.innerWidth<=600;r((function(){if(r(".owl-container .case").each((function(e,t){var n=r(t),a=n.attr("data-cover");n.css("backgroundImage","url(".concat(a,")"))})),r(".owl-container .case").click((function(e){r(".owl-container .case").removeClass("active"),r(e.target).addClass("active"),function(e){var t=r(e),n=r(".carousel .detail").empty(),o=t.attr("data-type"),i=t.attr("data-name");if(n.attr("data-name",i),"image"===o){var c=t.attr("data-cover");n.append('<div class="type-image" style="background-image: url('.concat(c,')"></div>'))}"model"===o&&(n.append('<div class="type-model" data-zdistance="2" data-rotate="x" data-color=""></div>'),Object(a.a)(r(".carousel .detail .type-model")[0],t.attr("data-model")))}(e.target)})),r(".owl-container .case").first().click(),r(".owl-carousel").owlCarousel({loop:!1,margin:o?10:15,nav:!0,autoWidth:!0,dots:!1}),o){var e=r('<div class="b2"></div>'),t=r(".b2").first();r(".page-title",t).first().appendTo(e),r(".company",t).appendTo(e),e.prependTo(r(".main"))}}))}});