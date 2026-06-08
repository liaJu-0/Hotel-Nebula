--Quartos disponíveis em determinado período
SELECT *
FROM quartos q
WHERE q.id_quarto NOT IN (
    SELECT id_quarto
    FROM reservas
    WHERE status <> 'Cancelada'
    AND '2026-07-15' <= data_checkout
    AND '2026-07-20' >= data_checkin
);

--Hóspedes que mais realizaram reservas
SELECT
    h.nome,
    COUNT(*) AS total_reservas
FROM hospedes h
INNER JOIN reservas r
ON h.id_hospede = r.id_hospede
GROUP BY h.nome
ORDER BY total_reservas DESC;

--Faturamento por mês
SELECT
    YEAR(data_pagamento) AS ano,
    MONTH(data_pagamento) AS mes,
    SUM(valor) AS faturamento
FROM pagamentos
GROUP BY ano, mes
ORDER BY ano, mes;

--Serviços mais consumidos
SELECT
    s.nome,
    SUM(cs.quantidade) AS total_consumido
FROM servicos s
INNER JOIN consumo_servicos cs
ON s.id_servico = cs.id_servico
GROUP BY s.nome
ORDER BY total_consumido DESC;

--Quartos com melhores avaliações
SELECT
    q.numero,
    AVG(f.nota) AS media_avaliacao
FROM quartos q
INNER JOIN feedbacks f
ON q.id_quarto = f.id_quarto
GROUP BY q.numero
ORDER BY media_avaliacao DESC;

--Reservas canceladas
SELECT *
FROM reservas
WHERE status = 'Cancelada';

--Quantas hospedagens cada funcionário atendeu
SELECT
    f.nome,
    COUNT(h.id_hospedagem) AS total_hospedagens
FROM funcionarios f
LEFT JOIN hospedagens h
ON f.id_funcionario = h.id_funcionario
GROUP BY f.nome;