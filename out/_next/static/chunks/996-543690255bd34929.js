(self.webpackChunk_N_E=self.webpackChunk_N_E||[]).push([[996],{3991:function(e,t){"use strict";Object.defineProperty(t,"__esModule",{value:!0}),function(e,t){for(var n in t)Object.defineProperty(e,n,{enumerable:!0,get:t[n]})}(t,{PrefetchKind:function(){return c},ACTION_REFRESH:function(){return n},ACTION_NAVIGATE:function(){return o},ACTION_RESTORE:function(){return r},ACTION_SERVER_PATCH:function(){return u},ACTION_PREFETCH:function(){return l},ACTION_FAST_REFRESH:function(){return f}});const n="refresh",o="navigate",r="restore",u="server-patch",l="prefetch",f="fast-refresh";var c;!function(e){e.AUTO="auto",e.FULL="full",e.TEMPORARY="temporary"}(c||(c={})),("function"===typeof t.default||"object"===typeof t.default&&null!==t.default)&&"undefined"===typeof t.default.__esModule&&(Object.defineProperty(t.default,"__esModule",{value:!0}),Object.assign(t.default,t),e.exports=t.default)},1516:function(e,t){"use strict";Object.defineProperty(t,"__esModule",{value:!0}),Object.defineProperty(t,"getDomainLocale",{enumerable:!0,get:function(){return n}});function n(e,t,n,o){return!1}("function"===typeof t.default||"object"===typeof t.default&&null!==t.default)&&"undefined"===typeof t.default.__esModule&&(Object.defineProperty(t.default,"__esModule",{value:!0}),Object.assign(t.default,t),e.exports=t.default)},5569:function(e,t,n){"use strict";Object.defineProperty(t,"__esModule",{value:!0}),Object.defineProperty(t,"default",{enumerable:!0,get:function(){return v}});const o=n(8754)._(n(7294)),r=n(4532),u=n(3353),l=n(1410),f=n(9064),c=n(370),a=n(9955),s=n(4224),i=n(508),d=n(1516),p=n(4266),y=n(3991),b=new Set;function h(e,t,n,o,r,l){if(!l&&!(0,u.isLocalURL)(t))return;if(!o.bypassPrefetchedCheck){const r=t+"%"+n+"%"+("undefined"!==typeof o.locale?o.locale:"locale"in e?e.locale:void 0);if(b.has(r))return;b.add(r)}const f=l?e.prefetch(t,r):e.prefetch(t,n,o);Promise.resolve(f).catch((e=>{0}))}function _(e){return"string"===typeof e?e:(0,l.formatUrl)(e)}const v=o.default.forwardRef((function(e,t){let n;const{href:l,as:b,children:v,prefetch:g=null,passHref:O,replace:C,shallow:m,scroll:E,locale:P,onClick:M,onMouseEnter:j,onTouchStart:R,legacyBehavior:T=!1,...k}=e;n=v,!T||"string"!==typeof n&&"number"!==typeof n||(n=o.default.createElement("a",null,n));const A=!1!==g,I=null===g?y.PrefetchKind.AUTO:y.PrefetchKind.FULL,L=o.default.useContext(a.RouterContext),x=o.default.useContext(s.AppRouterContext),N=null!=L?L:x,S=!L;const{href:w,as:U}=o.default.useMemo((()=>{if(!L){const e=_(l);return{href:e,as:b?_(b):e}}const[e,t]=(0,r.resolveHref)(L,l,!0);return{href:e,as:b?(0,r.resolveHref)(L,b):t||e}}),[L,l,b]),H=o.default.useRef(w),K=o.default.useRef(U);let F;T&&(F=o.default.Children.only(n));const D=T?F&&"object"===typeof F&&F.ref:t,[B,V,q]=(0,i.useIntersection)({rootMargin:"200px"}),z=o.default.useCallback((e=>{K.current===U&&H.current===w||(q(),K.current=U,H.current=w),B(e),D&&("function"===typeof D?D(e):"object"===typeof D&&(D.current=e))}),[U,D,w,q,B]);o.default.useEffect((()=>{N&&V&&A&&h(N,w,U,{locale:P},{kind:I},S)}),[U,w,V,P,A,null==L?void 0:L.locale,N,S,I]);const G={ref:z,onClick(e){T||"function"!==typeof M||M(e),T&&F.props&&"function"===typeof F.props.onClick&&F.props.onClick(e),N&&(e.defaultPrevented||function(e,t,n,r,l,f,c,a,s,i){const{nodeName:d}=e.currentTarget;if("A"===d.toUpperCase()&&(function(e){const t=e.currentTarget.getAttribute("target");return t&&"_self"!==t||e.metaKey||e.ctrlKey||e.shiftKey||e.altKey||e.nativeEvent&&2===e.nativeEvent.which}(e)||!s&&!(0,u.isLocalURL)(n)))return;e.preventDefault();const p=()=>{"beforePopState"in t?t[l?"replace":"push"](n,r,{shallow:f,locale:a,scroll:c}):t[l?"replace":"push"](r||n,{forceOptimisticNavigation:!i})};s?o.default.startTransition(p):p()}(e,N,w,U,C,m,E,P,S,A))},onMouseEnter(e){T||"function"!==typeof j||j(e),T&&F.props&&"function"===typeof F.props.onMouseEnter&&F.props.onMouseEnter(e),N&&(!A&&S||h(N,w,U,{locale:P,priority:!0,bypassPrefetchedCheck:!0},{kind:I},S))},onTouchStart(e){T||"function"!==typeof R||R(e),T&&F.props&&"function"===typeof F.props.onTouchStart&&F.props.onTouchStart(e),N&&(!A&&S||h(N,w,U,{locale:P,priority:!0,bypassPrefetchedCheck:!0},{kind:I},S))}};if((0,f.isAbsoluteUrl)(U))G.href=U;else if(!T||O||"a"===F.type&&!("href"in F.props)){const e="undefined"!==typeof P?P:null==L?void 0:L.locale,t=(null==L?void 0:L.isLocaleDomain)&&(0,d.getDomainLocale)(U,e,null==L?void 0:L.locales,null==L?void 0:L.domainLocales);G.href=t||(0,p.addBasePath)((0,c.addLocale)(U,e,null==L?void 0:L.defaultLocale))}return T?o.default.cloneElement(F,G):o.default.createElement("a",{...k,...G},n)}));("function"===typeof t.default||"object"===typeof t.default&&null!==t.default)&&"undefined"===typeof t.default.__esModule&&(Object.defineProperty(t.default,"__esModule",{value:!0}),Object.assign(t.default,t),e.exports=t.default)},508:function(e,t,n){"use strict";Object.defineProperty(t,"__esModule",{value:!0}),Object.defineProperty(t,"useIntersection",{enumerable:!0,get:function(){return a}});const o=n(7294),r=n(29),u="function"===typeof IntersectionObserver,l=new Map,f=[];function c(e,t,n){const{id:o,observer:r,elements:u}=function(e){const t={root:e.root||null,margin:e.rootMargin||""},n=f.find((e=>e.root===t.root&&e.margin===t.margin));let o;if(n&&(o=l.get(n),o))return o;const r=new Map,u=new IntersectionObserver((e=>{e.forEach((e=>{const t=r.get(e.target),n=e.isIntersecting||e.intersectionRatio>0;t&&n&&t(n)}))}),e);return o={id:t,observer:u,elements:r},f.push(t),l.set(t,o),o}(n);return u.set(e,t),r.observe(e),function(){if(u.delete(e),r.unobserve(e),0===u.size){r.disconnect(),l.delete(o);const e=f.findIndex((e=>e.root===o.root&&e.margin===o.margin));e>-1&&f.splice(e,1)}}}function a(e){let{rootRef:t,rootMargin:n,disabled:l}=e;const f=l||!u,[a,s]=(0,o.useState)(!1),i=(0,o.useRef)(null),d=(0,o.useCallback)((e=>{i.current=e}),[]);(0,o.useEffect)((()=>{if(u){if(f||a)return;const e=i.current;if(e&&e.tagName){return c(e,(e=>e&&s(e)),{root:null==t?void 0:t.current,rootMargin:n})}}else if(!a){const e=(0,r.requestIdleCallback)((()=>s(!0)));return()=>(0,r.cancelIdleCallback)(e)}}),[f,n,t,a,i.current]);const p=(0,o.useCallback)((()=>{s(!1)}),[]);return[d,a,p]}("function"===typeof t.default||"object"===typeof t.default&&null!==t.default)&&"undefined"===typeof t.default.__esModule&&(Object.defineProperty(t.default,"__esModule",{value:!0}),Object.assign(t.default,t),e.exports=t.default)},9008:function(e,t,n){e.exports=n(2636)},1664:function(e,t,n){e.exports=n(5569)}}]);