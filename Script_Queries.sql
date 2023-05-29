use restaurant;
-- Queries

-- 1. Quais os ingredientes presentes na receita Carbonara
select p.Descricao as Ingredientes 
from produto as p join receita_has_produto rhp on  rhp.Produto_idProduto = p.idProduto
join receita as r on r.idReceita = rhp.Receita_idReceita
where r.Nome = "Carbonara";	

-- 2. Selecionar todos os pedidos que tiveram o ingrediente Bife bem como o nome do funcionario que recolheu o pedido
select ped.idPedido, ped.Mesa_idMesa, ped.Data, f.Nome
from produto as p join receita_has_produto as rhp on rhp.Produto_idProduto = p.idProduto
join pedido_has_receita as phc on phc.Receita_idReceita = rhp.Receita_idReceita join pedido as ped
on ped.idPedido = phc.Pedido_idPedido join funcionario as f on f.idFuncionario = ped.Funcionario_idFuncionario
where p.Descricao = "Bife";

-- 3. Lista do numero de pedidos recolhidos pelos funcionarios, de forma descendente 
select p.Funcionario_idFuncionario, count(p.Funcionario_idFuncionario), f.Nome
from pedido as p join funcionario as f on p.Funcionario_idFuncionario = f.idFuncionario
group by p.Funcionario_idFuncionario
order by count(p.Funcionario_idFuncionario) DESC;


-- 4. Lista de produtos com menos de seis meses de validade, as quantidades e o nome do respeitvo fornecedor
select p.Descricao, p.Quantidade, f.Nome
from produto as p join fornecedor as f on p.Fornecedor_idFornecedor = f.idFornecedor
where Validade < "2023-09-12";

-- 5. Lista dos produtos com menos de 10 unidades em stock, bem como o nome do seu fornecedor
select p.Descricao, p.Quantidade, f.Nome
from produto as p join fornecedor as f on p.Fornecedor_idFornecedor = f.idFornecedor
where quantidade <= 20
order by p.Quantidade DESC;