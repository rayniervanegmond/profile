<template>
  <div class="hello">

    <div class="text-2xl text-blue-400 font-bold">Raynier van Egmond - Profile Page</div>
    {{ msg }}
  </div>
</template>

<script>
export default {
  name: 'ProfilePage',
  props: {
    msg: String
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
