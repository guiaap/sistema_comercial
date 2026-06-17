package com.empresa.sistema.model;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(
        name = "usuario",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "uk_usuario_email",
                        columnNames = "email"
                )
        }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 200)
    private String nome;

    @Column(nullable = false, length = 200, unique = true)
    private String email;

    @Column(nullable = false, length = 200)
    private String senha;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
            name = "id_perfil",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_usuario_perfil")
    )
    private Perfil perfil;
}