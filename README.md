# Tractian
Vídeo de demonstração ([Caso o vídeo não carregar, clique aqui](https://youtu.be/GWo8v7rAzOA)) </br>
<video width="600" controls>
  <source src="https://youtu.be/GWo8v7rAzOA" type="video/mp4">
</video>


## Melhorias no projeto
1. Se eu tivesse mais tempo para trabalhar no projeto, buscaria melhorar o desempenho de carregamento da terceira empresa, a Apex. Eu consideraria substituir o uso de `ListView.builder()` que está atualmente no projeto por um SliverList, o que poderia proporcionar um ganho de desempenho ao manipular a UI de uma maneira mais eficiente, evitando o uso de propriedades como `shrinkWrap` e `NeverScrollableScrollPhysics()`, por exemplo. Além disso, tentaria implementar uma abordagem de 'lazy loading' na estrutura de árvore, onde cada nó seria renderizado com um pequeno atraso, para evitar o congelamento que ocorre no início do carregamento da tela.

2. Buscaria adicionar também o salvamento das informações em cache, no que diz respeito aos registros da árvore de ativos/locais/componentes.
